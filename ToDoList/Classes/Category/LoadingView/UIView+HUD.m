//
//  UIView+HUD.m
//  OucOclass
//
//  Created by 钟小麦 on 2017/10/24.
//  Copyright © 2017年 zxd. All rights reserved.
//

#import "UIView+HUD.h"
#import "JGProgressHUD.h"
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
    
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud.tag = BCHudTag;
    hud.textLabel.text = msg;
    hud.userInteractionEnabled = NO;
    [hud showInView:self animated:NO] ;
}


/** 没有点击点击事件作 */
-(void)showLoadingWitBlackGroundViewWithMessage:(NSString *)msg
{
    [self dissmissHud];
    
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud.tag = BCHudTag;
    hud.backgroundColor = kRGBA_COLOR(0, 0, 0, 0.3);
    hud.textLabel.text = msg;
    hud.userInteractionEnabled = YES;
    [hud showInView:self animated:NO] ;
}

-(void)showLoadingInWindowWithMessage:(NSString *)msg
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud.tag = BCHudTag;
    hud.backgroundColor = kRGBA_COLOR(0, 0, 0, 0.3);
    hud.textLabel.text = msg;
    hud.userInteractionEnabled = YES;
    [hud showInView:window animated:NO] ;
}

-(void)dissmissHud
{
    JGProgressHUD *hud = [self viewWithTag:BCHudTag];
    if (hud) {
        [hud dismissAnimated:NO];
        [hud removeFromSuperview];
    }
}

-(void)dissmissWindowHud
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    JGProgressHUD *hud = [window viewWithTag:BCHudTag];
    if (hud) {
        [hud dismissAnimated:NO];
        [hud removeFromSuperview];
    }
}
#pragma mark - *********** show Sucess **********

-(void)showSucessHudWithMessage:(NSString *)msg
{
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud .textLabel.text = msg?msg:@"sucess";
    hud.indicatorView = [[JGProgressHUDImageIndicatorView alloc]initWithImage:[UIImage imageNamed:@"MBHUD_Success"]];
//    hud.square = YES;
    [hud showInView:self animated:NO] ;
    [hud  dismissAfterDelay:1.5];
}

-(void)showSucessHud
{
    [self showSucessHudWithMessage:nil];
}

#pragma mark - *********** show Error **********

-(void)showErrorHudWithMessage:(NSString *)msg
{
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud .textLabel.text = msg?msg:@"error";
    hud.indicatorView = [[JGProgressHUDImageIndicatorView alloc]initWithImage:[UIImage imageNamed:@"MBHUD_Error"]];
    [hud showInView:self animated:NO] ;
    [hud dismissAfterDelay:1.5];
}

-(void)showErrorHud
{
    [self showErrorHudWithMessage:nil];
}


#pragma mark - *********** show Info **********

-(void)showInfoHudWithMessage:(NSString *)msg
{
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud .textLabel.text = msg?msg:@"Error!";
    hud.indicatorView = [[JGProgressHUDImageIndicatorView alloc]initWithImage:[UIImage imageNamed:@"MBHUD_Warn"]];

    [hud showInView:self animated:NO] ;
    [hud  dismissAfterDelay:1.5];
}

-(void)showTextHudInMiddleWithMessage:(NSString *)msg
{
    [self showOnlyTextInPossition:JGProgressHUDPositionCenter andMessage:msg];
}


- (void)showTextHudInBottomWithMessage:(NSString *)msg
{
    
    [self showOnlyTextInPossition:JGProgressHUDPositionBottomCenter andMessage:msg];
}

-(void)showOnlyTextInPossition:(JGProgressHUDPosition)position andMessage:(NSString *)msg
{
    
    JGProgressHUD *HUD = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    
    HUD.indicatorView = nil;
    HUD.userInteractionEnabled = NO;
    HUD.textLabel.text = msg;
    HUD.position = position;
    HUD.tag = BCHudTag;

    HUD.layoutMargins = (UIEdgeInsets) {
        .top = 0.0f,
        .bottom = 20.0f,
        .left = 0.0f,
        .right = 0.0f,
    };
    
    [HUD showInView:self animated:NO] ;
    
    [HUD dismissAfterDelay:1.5];
}




@end
