//
//  MJRecorderTool.h
//  ToDoList
//
//  Created by MarkLwis on 2022/2/9.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYLevelPairs.h"

typedef void(^MJRecordingStopCompletionHandler)(BOOL);
typedef void(^MJRecordingSaveCompletionHandler)(BOOL, id);
typedef void(^MJAudioPlayerStopPlayingCompletionHandler)(BOOL);

@class TYMemo;
@interface MJRecorderTool : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, copy, readonly) NSString *formattedCurrentTime;
@property (nonatomic, copy) MJAudioPlayerStopPlayingCompletionHandler audioPlayerStopPlayingCompletionHandler;

- (BOOL)record;
- (void)pause;

- (void)stopWithCompletionHandler:(MJRecordingStopCompletionHandler)handler;
- (void)saveRecordingWithName:(NSString *)name completionHandler:(MJRecordingSaveCompletionHandler)handler;

- (BOOL)playbackMemo:(TYMemo *)memo;
- (void)audioPlayerStopPlaying:(MJAudioPlayerStopPlayingCompletionHandler)stopPlayingHandler;

- (TYLevelPairs *)levels;

@end
