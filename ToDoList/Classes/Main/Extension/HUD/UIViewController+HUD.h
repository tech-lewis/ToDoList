//
//  UIViewController+HUD.h
//  OucOclass
//
//  Created by zc on 2017/6/21.
//  Copyright © 2017年 eenet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

#pragma mark - *********** show Lodign **********

-(void)showLoadingHud;

-(void)showLoadingHudWithMessage:(NSString *)msg;

/** showLoding-InWindow   */
-(void)showLoadingInWindow;
-(void)showLoadingInWindowWithMessage:(NSString *)msg;


#pragma mark - *********** show Dismiss **********

-(void)dissmissHud;


#pragma mark - *********** show Sucess **********

-(void)showSucessHud;
-(void)showSucessHudWithMessage:(NSString *)msg;
-(void)showSucessHudWithMessage:(NSString *)msg completion:(void(^)(void))finishBlock;;


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
