//
//  UIButton+CU_CountDownBtn.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//  倒计时Btn分类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CU_CountDownBtn)

/**
 获取短信验证码倒计时
 
 @param duration 倒计时时间
 @param isSelected 倒计时结束后按钮是否选中状态
 @param color 倒计时结束后按钮颜色
 */
- (void)startTimeWithDuration:(NSInteger)duration andIsSelected:(BOOL) isSelected andTintColor:(UIColor *) color ;

@end

NS_ASSUME_NONNULL_END
