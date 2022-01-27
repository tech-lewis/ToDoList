//
//  PJLVoice.h
//  PJLVoice
//
//  Created by 裴建兰 on 2018/3/29.
//  Copyright © 2018年 PJL. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
/*
 */

typedef void(^PJLVoiceStatusBlock)(NSInteger status,AVSpeechSynthesizer *synthesizer,AVSpeechUtterance *utterance);

typedef void(^PJLVoiceReadingBlock)(AVSpeechSynthesizer *synthesizer,AVSpeechUtterance *utterance,NSRange characterRange);

@interface PJLReadObject : NSObject

@property (nonatomic) PJLVoiceStatusBlock pjlVoiceStatusBlock;

@property (nonatomic) PJLVoiceReadingBlock pjlVoiceReadingBlock;


/*
 * param readString 需要朗读的字符串内容
 * param rate     设置语速
 * param pitchMultiplier 设置音高 [0.5 - 2]
 * param volume  设置音量[0~1]
 * param preUtteranceDelay 读一段前的停顿时间
 * param postUtteranceDelay 读完后的停顿时间
 * param language   语言 默认 BCP-47
 */
- (void)readWithString:(NSString *)readString
     withUtteranceRate:(CGFloat)rate
   withPitchMultiplier:(CGFloat)pitchMultiplier
            withVolume:(CGFloat)volume
 withPreUtteranceDelay:(NSTimeInterval)preUtteranceDelay
withPostUtteranceDelay:(NSTimeInterval)postUtteranceDelay
          withLanguage:(NSString *)language;

/*代理监听
 * param statusBlock 状态bock监听 0 开始 1 暂停 2继续 3取消 4完成
 * param readingBlock 过程监听
 */
- (void)setAVSpeechSynthesizerDelegatewithPJLVoiceStatusBlock:(PJLVoiceStatusBlock)statusBlock
                                     withPJLVoiceReadingBlock:(PJLVoiceReadingBlock )readingBlock;


/*暂停
 *param aVSpeechBoundary  AVSpeechBoundaryImmediate,AVSpeechBoundaryWord
 *block  监听block
 */
- (void)setPause:(AVSpeechBoundary)aVSpeechBoundary
       withBlock:(void(^)(BOOL sucess))block;

/*停止
 *param aVSpeechBoundary  AVSpeechBoundaryImmediate,AVSpeechBoundaryWord
 *block  监听block
 */
- (void)stopSpeak:(AVSpeechBoundary)aVSpeechBoundary
        withBlock:(void(^)(BOOL sucess))block;

/*继续朗读
 *param aVSpeechBoundary  AVSpeechBoundaryImmediate,AVSpeechBoundaryWord
 *block  监听block
 */
- (void)continueSpeak:(AVSpeechBoundary)aVSpeechBoundary
            withBlock:(void(^)(BOOL sucess))block;
@end
