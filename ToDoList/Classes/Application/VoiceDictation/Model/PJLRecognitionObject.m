//
//  PJLRecognitionObject.m
//  PJLVoice
//
//  Created by 裴建兰 on 2018/4/3.
//  Copyright © 2018年 PJL. All rights reserved.
//

#import "PJLRecognitionObject.h"
API_AVAILABLE(ios(10.0))
@interface PJLRecognitionObject()<SFSpeechRecognizerDelegate>{
    
}
@property (nonatomic,strong) SFSpeechRecognizer *speechRecognizer;
@property (nonatomic,strong) AVAudioEngine *audioEngine;
@property (nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;

@property (nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
@end

@implementation PJLRecognitionObject

- (id)init{
    
    self = [super init];
    if(self){
        
    }
    return self;
    
}

/*
 *  监听一些字段
 */
- (void)setListenBlock:(PJLRecognitionBlock)block{
    
    self.pjlRecognitionBlock = block;
    
}

/* 检查授权状态
 * @param block  SFSpeechRecognizerAuthorizationStatus
 */
- (void)checkPower:( void(^)(SFSpeechRecognizerAuthorizationStatus status))block API_AVAILABLE(ios(10.0)){
    
//    __weak typeof(self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(status);
            });
        }];
    } else {
        // Fallback on earlier versions
    }
    
}

/*
 *开始录制
 * @param bestTranscriptionFormattedString 识别出来的语言
 * @param status 0 是没起效，1 是可以录音 2 录音结束
 */
- (void)startRecording{
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    NSParameterAssert(!error);
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    
    if (@available(iOS 10.0, *)) {
        _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    } else {
        
     
        return;
        // Fallback on earlier versions
    }
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode, @"录入设备没有准备好");
    NSAssert(_recognitionRequest, @"请求初始化失败");
    _recognitionRequest.shouldReportPartialResults = YES;
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            BOOL isFinal = NO;
            if (result) {
//                strongSelf.resultStringLable.text = result.bestTranscription.formattedString;
                NSLog(@"%@",result.bestTranscription.formattedString);
                 if(self.pjlRecognitionBlock){
                     self.pjlRecognitionBlock(result.bestTranscription.formattedString,2);
                     
                 }
                
                isFinal = result.isFinal;
            }
            if (error || isFinal) {
                [self.audioEngine stop];
                [inputNode removeTapOnBus:0];
                strongSelf.recognitionTask = nil;
                strongSelf.recognitionRequest = nil;
                NSLog(@"开始录音");
                if(self.pjlRecognitionBlock){
                    self.pjlRecognitionBlock(result.bestTranscription.formattedString,1);
                    
                }
                //开始录音
                
            }
            
        }];
    } else {
        // Fallback on earlier versions
    }
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
    [inputNode removeTapOnBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.recognitionRequest) {
            [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
        }
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
//    self.resultStringLable.text = LoadingText;
}

/*
 *结束录制
 */
- (void)endRecording{
    [self.audioEngine stop];
    if (_recognitionRequest) {
        [_recognitionRequest endAudio];
    }
    
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
//    self.recordButton.enabled = NO;
//
//    if ([self.resultStringLable.text isEqualToString:LoadingText]) {
//        self.resultStringLable.text = @"";
//    }
}

/*
 * @param urlPath 识别的文件所在的地址
 * @param Block   返回参数识别内容
 * @param localString 默认是zh_CN 识别语言
 */
- (void)recognizeLocalAudioFile:(NSString *)urlPath
                withRecordBlock:(void(^)(NSString *recordStr))Block
          whithLocaleIdentifier:(NSString *)localString
                        API_AVAILABLE(ios(10.0)){
                            
                            if(localString == nil){
                                
                                localString = @"zh_CN";
                                
                            }
                            
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:localString];
    SFSpeechRecognizer *localRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
    NSURL *url = [NSURL URLWithString:urlPath];
    if (!url) return;
    SFSpeechURLRecognitionRequest *res =[[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
  
    [localRecognizer recognitionTaskWithRequest:res resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            if(self.pjlRecognitionBlock){
                self.pjlRecognitionBlock(error.description,0);
                
            }
            NSLog(@"语音识别解析失败,%@",error);
            Block(nil);
            
        }else{
            
            if(self.pjlRecognitionBlock){
                self.pjlRecognitionBlock(result.bestTranscription.formattedString,3);
                
            }
            
            Block(result.bestTranscription.formattedString);
            
        }
    }];
}

/* 这个方法就是单纯的识别本地的数据方法
 * @param urlPath 识别的文件所在的地址
 * @param Block   返回参数识别内容
 * @param localString 默认是zh_CN 识别语言
 */
- (void)recognizeLocalWithEendStatusAudioFile:(NSString *)urlPath
                withRecordBlock:(void(^)(NSString *recordStr,BOOL isEnd))Block
          whithLocaleIdentifier:(NSString *)localString
API_AVAILABLE(ios(10.0)){
    
    if(localString == nil){
        
        localString = @"zh_CN";
        
    }
    
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:localString];
    SFSpeechRecognizer *localRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
    NSURL *url = [NSURL URLWithString:urlPath];
    if (!url) return;
    SFSpeechURLRecognitionRequest *res =[[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    
    [localRecognizer recognitionTaskWithRequest:res resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
          
            NSLog(@"语音识别解析失败,%@",error);
           
              Block(nil,result.final);
        }else{
            
            
           Block(result.bestTranscription.formattedString,result.final);
        }
    }];
}



#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available API_AVAILABLE(ios(10.0)){
    if (available) {
//        self.recordButton.enabled = YES;
//        [self.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
        
    }
    else{
//        self.recordButton.enabled = NO;
//        [self.recordButton setTitle:@"语音识别不可用" forState:UIControlStateDisabled];
    }
}

#pragma mark - property
- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}
- (SFSpeechRecognizer *)speechRecognizer API_AVAILABLE(ios(10.0)){
    if (!_speechRecognizer) {
        //腰围语音识别对象设置语言，这里设置的是中文
        NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        _speechRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

@end
