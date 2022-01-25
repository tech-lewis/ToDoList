//
//  UIButton+CU_CountDownBtn.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "UIButton+CU_CountDownBtn.h"
#import "CU_Define.h"
@implementation UIButton (CU_CountDownBtn)

/**
 获取短信验证码倒计时
 
 @param duration 倒计时时间
 @param isSelected 倒计时结束后按钮是否选中状态
 @param color 倒计时结束后按钮颜色
 */
- (void)startTimeWithDuration:(NSInteger)duration andIsSelected:(BOOL) isSelected andTintColor:(UIColor *) color
{
    __block NSInteger timeout = duration;
    
    NSString *originalTitle = [self titleForState:UIControlStateNormal];
    UIColor *originalTitleColor = [self titleColorForState:UIControlStateNormal];
    //    UIFont *originalFont = self.titleLabel.font;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer_t,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer_t, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(timer_t);
            kWeakSelf(self)
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮为最初的状态
                if (isSelected) {
                    [weakself setTitle:originalTitle forState:UIControlStateSelected];
                    [weakself setTitleColor:originalTitleColor forState:UIControlStateSelected];
                }else{
                    [weakself setTitle:originalTitle forState:UIControlStateNormal];
                    [weakself setTitleColor:originalTitleColor forState:UIControlStateNormal];
                }
                weakself.selected = isSelected ;
                weakself.tintColor = color ;
                weakself.enabled = YES ;
                
            });
        }else{
            NSInteger seconds = timeout % duration;
            if(seconds == 0){
                seconds = duration;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2ld", (long)seconds];
            kWeakSelf(self)
            dispatch_async(dispatch_get_main_queue(), ^{//根据自己需求设置倒计时显示
                weakself.enabled = NO ;
                if (isSelected) {
                    [weakself setTitle:[NSString stringWithFormat:@" %@秒",strTime] forState:UIControlStateSelected];
                }else{
                    [weakself setTitle:[NSString stringWithFormat:@" %@秒",strTime] forState:UIControlStateNormal];
                }
            });
            timeout--;
        }
    });
    dispatch_resume(timer_t);
}

@end
