//
//  UIView+HUD.h
//  OucOclass
//
//  Created by 钟小麦 on 2017/10/24.
//  Copyright © 2017年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)

-(void)showLoadingHud;

-(void)showLoadingHudWithMessage:(NSString *)msg;

/** 没有点击点击事件作 */
-(void)showLoadingWitBlackGroundViewWithMessage:(NSString *)msg;

/** showLoding-InWindow  消失需要调用 dissmissWindowHud */
-(void)showLoadingInWindowWithMessage:(NSString *)msg;


-(void)dissmissHud;
-(void)dissmissWindowHud;

#pragma mark - *********** show Sucess **********

-(void)showSucessHud;
-(void)showSucessHudWithMessage:(NSString *)msg;


#pragma mark - *********** show Error **********

-(void)showErrorHud;
-(void)showErrorHudWithMessage:(NSString *)msg;


#pragma mark - *********** show Info **********


-(void)showInfoHudWithMessage:(NSString *)msg;

/** 展示文字在底部 */
-(void)showTextHudInBottomWithMessage:(NSString *)msg;

/** 展示文字在中间 */
-(void)showTextHudInMiddleWithMessage:(NSString *)msg;


@end
