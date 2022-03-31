//
//  TYRecorderTool.m
//  VoiceMemoDemo
//
//  Created by Maty on 2018/8/1.
//  Copyright © 2018年 kangarootec. All rights reserved.
//

#import "MJRecorderTool.h"
#import <AVFoundation/AVFoundation.h>
#import "TYMemo.h"
#import "TYMeterTable.h"

static MJRecorderTool *_instance = nil;

@interface MJRecorderTool () <
AVAudioRecorderDelegate,
AVAudioPlayerDelegate
>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) MJRecordingStopCompletionHandler stopCompletionHander;
@property (nonatomic, strong) TYMeterTable *meterTable;

@end

@implementation MJRecorderTool

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init {
  if (self = [super init]) {
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil)
    {
      NSLog(@"Error creating session: %@", [sessionError description]);
    }
    else
    {
      [session setActive:YES error:nil];
    }
    NSString *tmpDir = NSTemporaryDirectory();
    NSString *filePath = [tmpDir stringByAppendingPathComponent:@"memo.mp3"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
      
    NSMutableDictionary *audioSetting = [NSMutableDictionary dictionary];
    
    // 设置录音格式 kAudioFormatMPEGLayer3设置貌似是没用的 默认设置就行
    [audioSetting setObject:@(kAudioFormatMPEGLayer3) forKey:AVFormatIDKey];
    
    // 设置录音采样率，8000 44100 96000，对于一般录音已经够了
    [audioSetting setObject:@(22150) forKey:AVSampleRateKey];
    
    // 设置通道 1 2
    [audioSetting setObject:@(1) forKey:AVNumberOfChannelsKey];
    
    // 每个采样点位数,分为8、16、24、32
    [audioSetting setObject:@(16) forKey:AVLinearPCMBitDepthKey];
    
    // 是否使用浮点数采样 如果不是MP3需要用Lame转码为mp3的一定记得设置NO！(不然转码之后的声音一直都是杂音)
    // 是否使用浮点数采样 如果不是MP3需要用Lame转码为mp3的一定记得设置NO！(不然转码之后的声音一直都是杂音)
    // 是否使用浮点数采样 如果不是MP3需要用Lame转码为mp3的一定记得设置NO！(不然转码之后的声音一直都是杂音)
    
    [audioSetting setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    // 录音质量
    [audioSetting setObject:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
    
      
      NSError *error;
      self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:audioSetting error:&error];
      
      if (self.audioRecorder) {
          self.audioRecorder.delegate = self;
          // 开启音频测量
          self.audioRecorder.meteringEnabled = YES;
          [self.audioRecorder prepareToRecord];
      } else {
          NSLog(@"Error: %@",[error localizedDescription]);
      }
      
      _meterTable = [[TYMeterTable alloc] init];
      
      
  }
  return self;
}

#pragma mark - Custom Method
- (BOOL)record {
    return [self.audioRecorder record];
}

- (void)pause {
    [self.audioRecorder pause];
}

- (void)stopWithCompletionHandler:(MJRecordingStopCompletionHandler)handler {
    self.stopCompletionHander = handler;
    [self.audioRecorder stop];
}

- (void)saveRecordingWithName:(NSString *)name completionHandler:(MJRecordingSaveCompletionHandler)handler {
    NSTimeInterval timestamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *filename = [NSString stringWithFormat:@"%@-%f.mp3", name, timestamp];
    NSString *docsDir = [self documentsDirectory];
    NSString *destPath = [docsDir stringByAppendingPathComponent:filename];
    NSURL *srcURL = self.audioRecorder.url;
    NSURL *destURL = [NSURL fileURLWithPath:destPath];
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:srcURL toURL:destURL error:&error];
    
    if (success) {
        handler(YES, [TYMemo memoWithTitle:name url:destURL]);
        [self.audioRecorder prepareToRecord];
    } else {
        handler(NO, error);
    }
}

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

- (BOOL)playbackMemo:(TYMemo *)memo {
    [self.audioPlayer stop];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:memo.url error:nil];

    if (self.audioPlayer) {
        self.audioPlayer.delegate = self;
        [self.audioPlayer play];
        return YES;
    }
    
    return NO;
}

- (void)audioPlayerStopPlaying:(MJAudioPlayerStopPlayingCompletionHandler)stopPlayingHandler {
    self.stopCompletionHander = stopPlayingHandler;
    [self.audioPlayer stop];
}

- (TYLevelPairs *)levels {
    [self.audioRecorder updateMeters];
    float avgPower = [self.audioRecorder averagePowerForChannel:0];
    float peakPower = [self.audioRecorder peakPowerForChannel:0];
    float linearLevel = [self.meterTable valueForPower:avgPower];
    float linearPeak = [self.meterTable valueForPower:peakPower];
    return [TYLevelPairs levelsWithLevel:linearLevel peakLevel:linearPeak];
}

#pragma mark -
- (NSString *)formattedCurrentTime {
    NSUInteger time = (NSUInteger)self.audioRecorder.currentTime;
    NSInteger hours = (time / 3600);
    NSInteger minutes = (time / 60) % 60;
    NSInteger seconds = time % 60;
    return [NSString stringWithFormat:@"%02li:%02li:%02li",(long)hours,(long)minutes,(long)seconds];
}

#pragma mark - <AVAudioRecorderDelegate>
// 录音完成或停止时被调用,如果被中断而停止,不调用此方法
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (self.stopCompletionHander) {
        self.stopCompletionHander(flag);
    }
}

#pragma mark - <AVAudioPlayerDelegate>
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (self.audioPlayerStopPlayingCompletionHandler) {
        self.audioPlayerStopPlayingCompletionHandler(flag);
    }
}

@end
