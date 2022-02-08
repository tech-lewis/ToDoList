//
//  PJLRecognitionObject.h
//  PJLVoice
//
//  Created by 裴建兰 on 2018/4/3.
//  Copyright © 2018年 PJL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
typedef void(^PJLRecognitionBlock)(NSString *str,NSInteger status);

@interface PJLRecognitionObject : NSObject

@property (nonatomic) PJLRecognitionBlock pjlRecognitionBlock;

/*
 *  监听一些字段  status 0 是没起效，1 是可以录音 2 录音结束
 */
- (void)setListenBlock:(PJLRecognitionBlock)block;

/* 检查授权状态
 * @param block  SFSpeechRecognizerAuthorizationStatus
 */
- (void)checkPower:( void(^)(SFSpeechRecognizerAuthorizationStatus status))block API_AVAILABLE(ios(10.0));

/*
 *结束录制
 */
- (void)endRecording;

/*
 *开始识别 触发这个方法
 * @param bestTranscriptionFormattedString 识别出来的语言
 * @param status 0 是没起效，1 是可以录音 2 录音结束
 */
- (void)startRecording;


/*
 * @param urlPath 识别的文件所在的地址
 * @param Block   返回参数识别内容
 * @param localString 默认是zh_CN 识别语言
 */
- (void)recognizeLocalAudioFile:(NSString *)urlPath
                withRecordBlock:(void(^)(NSString *recordStr))Block
          whithLocaleIdentifier:(NSString *)localString
            API_AVAILABLE(ios(10.0));


/* 这个方法就是单纯的识别本地的数据方法
 * @param urlPath 识别的文件所在的地址
 * @param Block   返回参数识别内容
 * @param localString 默认是zh_CN 识别语言
 */
- (void)recognizeLocalWithEendStatusAudioFile:(NSString *)urlPath
                              withRecordBlock:(void(^)(NSString *recordStr,BOOL isEnd))Block
                        whithLocaleIdentifier:(NSString *)localString
API_AVAILABLE(ios(10.0));

@end
