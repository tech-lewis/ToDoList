//
//  UIViewController+HUD.m
//  OucOclass
//
//  Created by 钟小麦 on 2017/10/24.
//  Copyright © 2017年 zxd. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "JGProgressHUD.h"
#import "UIView+HUD.h"

@implementation UIViewController (HUD)

#pragma mark - *********** show Lodign **********
-(void)showLoadingHud
{
    [self.view showLoadingHud];
}

-(void)showLoadingHudWithMessage:(NSString *)msg
{
    [self.view showLoadingHudWithMessage:msg];
}

/** 没有点击点击事件作 */
-(void)showLoadingWitBlackGroundViewWithMessage:(NSString *)msg
{
    [self.view showLoadingWitBlackGroundViewWithMessage:msg];
}

/** showLoding-InWindow  消失需要调用 dissmissWindowHud */
-(void)showLoadingInWindowWithMessage:(NSString *)msg
{
    [self.view showLoadingInWindowWithMessage:msg];
}

#pragma mark - *********** show Dismiss **********

-(void)dissmissHud
{
    [self.view dissmissHud];
}
-(void)dissmissWindowHud
{
    [self.view dissmissWindowHud];
}
#pragma mark - *********** show Sucess **********

-(void)showSucessHud
{
    [self.view showSucessHud];
}
-(void)showSucessHudWithMessage:(NSString *)msg
{
    [self.view showSucessHudWithMessage:msg];
}


#pragma mark - *********** show Error **********

-(void)showErrorHud
{
    [self.view showErrorHud];
}
-(void)showErrorHudWithMessage:(NSString *)msg
{
    [self.view showErrorHudWithMessage:msg];
}


#pragma mark - *********** show Info **********

-(void)showInfoHudWithMessage:(NSString *)msg
{
    [self.view showInfoHudWithMessage:msg];
    
}

-(void)showTextHudInBottomWithMessage:(NSString *)msg
{
    [self.view showTextHudInBottomWithMessage:msg];
}

-(void)showTextHudInMiddleWithMessage:(NSString *)msg
{
    [self.view showTextHudInMiddleWithMessage:msg];
}

@end
