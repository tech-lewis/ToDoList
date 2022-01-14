//
//  UIView+HUD.m
//  OucOclass
//
//  Created by 钟小麦 on 2017/10/24.
//  Copyright © 2017年 zxd. All rights reserved.
//

#import "UIView+HUD.h"
#import <objc/runtime.h>

#define BCHudTag 99999
@interface UIView ()
@end

@implementation UIView (HUD)


#pragma mark - *********** show Logding **********

-(void)showLoadingHud
{
    [self showLoadingHudWithMessage:@" 加载中... "];
}


- (void)showLoadingHudWithMessage:(NSString *)msg
{
    [self dissmissHud];
}


/** 没有点击点击事件作 */
-(void)showLoadingWitBlackGroundViewWithMessage:(NSString *)msg
{
    [self dissmissHud];
}

-(void)showLoadingInWindowWithMessage:(NSString *)msg {}
-(void)dissmissHud {}
-(void)dissmissWindowHud {}
#pragma mark - *********** show Sucess **********

-(void)showSucessHudWithMessage:(NSString *)msg {}
-(void)showSucessHud
{
    [self showSucessHudWithMessage:nil];
}

#pragma mark - *********** show Error **********

-(void)showErrorHudWithMessage:(NSString *)msg {}

-(void)showErrorHud
{
    [self showErrorHudWithMessage:nil];
}


#pragma mark - *********** show Info **********

- (void)showInfoHudWithMessage:(NSString *)msg {}
- (void)showTextHudInMiddleWithMessage:(NSString *)msg {}
- (void)showTextHudInBottomWithMessage:(NSString *)msg {}
@end
