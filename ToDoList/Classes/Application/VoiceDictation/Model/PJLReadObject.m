//
//  PJLVoice.m
//  PJLVoice
//
//  Created by 裴建兰 on 2018/3/29.
//  Copyright © 2018年 PJL. All rights reserved.
//

#import "PJLReadObject.h"


@interface PJLReadObject()<AVSpeechSynthesizerDelegate>{
    
    AVSpeechSynthesizer *_avSpeaker;
}
@end

@implementation PJLReadObject

- (id)init{
    
    self = [super init];
    if(self){
        
        _avSpeaker = [[AVSpeechSynthesizer alloc]init];
        _avSpeaker.delegate = self;
        
    }
    
    return self;
    
}
/*暂停
 *param aVSpeechBoundary  AVSpeechBoundaryImmediate,AVSpeechBoundaryWord
 *block  监听block
 */
- (void)setPause:(AVSpeechBoundary)aVSpeechBoundary
       withBlock:(void(^)(BOOL sucess))block{
    
    block([_avSpeaker pauseSpeakingAtBoundary:aVSpeechBoundary]);
    
}

/*停止
 *param aVSpeechBoundary  AVSpeechBoundaryImmediate,AVSpeechBoundaryWord
 *block  监听block
 */
- (void)stopSpeak:(AVSpeechBoundary)aVSpeechBoundary
        withBlock:(void(^)(BOOL sucess))block{
    
    block( [_avSpeaker stopSpeakingAtBoundary:aVSpeechBoundary]);
    
}
/*继续朗读
 *param aVSpeechBoundary  AVSpeechBoundaryImmediate,AVSpeechBoundaryWord
 *block  监听block
 */
- (void)continueSpeak:(AVSpeechBoundary)aVSpeechBoundary
            withBlock:(void(^)(BOOL sucess))block{
    
    
    block([_avSpeaker continueSpeaking]);
}


/*代理监听
 * param statusBlock 状态bock监听 0 开始 1 暂停 2继续 3取消 4完成
 * param readingBlock 过程监听
 */
- (void)setAVSpeechSynthesizerDelegatewithPJLVoiceStatusBlock:(PJLVoiceStatusBlock)statusBlock
                                     withPJLVoiceReadingBlock:(PJLVoiceReadingBlock )readingBlock{
    
    _pjlVoiceStatusBlock = statusBlock;
    
    _pjlVoiceReadingBlock = readingBlock;
}

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
          withLanguage:(NSString *)language{
    
    if(language == nil){
        
        language = @"BCP-47";
    }
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:readString];
    utterance.rate = rate;  //设置语速
    utterance.pitchMultiplier = pitchMultiplier; //设置音高
    
    utterance.volume = volume; //设置音量
    
    utterance.preUtteranceDelay = preUtteranceDelay; //读一段前的停顿时间
    
    utterance.postUtteranceDelay = postUtteranceDelay; //读完后的停顿时间
    
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:language];
    
    
    //    NSLog(@"%@",[AVSpeechSynthesisVoice speechVoices]);
    
    utterance.voice = voice;
    
    [_avSpeaker speakUtterance:utterance];
}


#pragma mark AVSpeechSynthesizerDelegate

//开始
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
 
    if(_pjlVoiceStatusBlock != nil){
        _pjlVoiceStatusBlock(0,synthesizer,utterance);
        
    }
}

//完成朗读
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{

    if(_pjlVoiceStatusBlock != nil){
        _pjlVoiceStatusBlock(4,synthesizer,utterance);
        
    }

}

//暂停朗读
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    
    if(_pjlVoiceStatusBlock != nil){
        _pjlVoiceStatusBlock(1,synthesizer,utterance);
        
    }
}

//继续朗读
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
  
    if(_pjlVoiceStatusBlock != nil){
        _pjlVoiceStatusBlock(2,synthesizer,utterance);
        
    }
}

//取消朗读
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
 
    if(_pjlVoiceStatusBlock != nil){
        _pjlVoiceStatusBlock(3,synthesizer,utterance);
        
    }
}

//朗读区域范围
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    
    _pjlVoiceReadingBlock(synthesizer,utterance,characterRange);
//    NSLog(@"location == %lu,length=%lu",(unsigned long)characterRange.location,(unsigned long)characterRange.length);
 
    
}


@end
