//
//  UIView+HUD.m
//  OucOclass
//
//  Created by zc on 2017/6/21.
//  Copyright © 2017年 eenet. All rights reserved.
//

#import "UIView+HUD.h"

#import "SVProgressHUD.h"
#import "JGProgressHUD.h"

#define BCHudTag 99988
#define JGHudTag 88811

@implementation UIView (HUD)


#pragma mark - *********** show Logding **********

-(void)showLoadingHud {
    [self showLoadingHudWithMessage:nil];
}

-(void)showLoadingHudWithMessage:(NSString *)msg {
    
    [self dissmissHud];
    JGProgressHUD *hud = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];
    hud.textLabel.text = msg;
    hud.tag = JGHudTag;
    hud.userInteractionEnabled = NO;
    [hud showInView:self animated:NO];
}

-(void)showLoadingInWindow {
    [self showLoadingInWindowWithMessage:nil];
}
-(void)showLoadingInWindowWithMessage:(NSString *)msg {
   
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumSize:CGSizeMake(80, 80)];
    [SVProgressHUD showWithStatus:msg];
    
}

-(void)dissmissHud {
    
    JGProgressHUD *jgHud = [self viewWithTag:JGHudTag];
    if (jgHud) {
        [jgHud dismissAnimated:YES];
        [jgHud removeFromSuperview];
        
    }
    [SVProgressHUD dismiss];
}


#pragma mark - *********** show Sucess **********

-(void)showSucessHudWithMessage:(NSString *)msg {
    
    [self showSucessHudWithMessage:msg completion:nil];
}

-(void)showSucessHudWithMessage:(NSString *)msg completion:(void (^)(void))finishBlock {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showSuccessWithStatus:msg];
     
    if (finishBlock) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            finishBlock();
        });
    }else {
         [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    }
}


-(void)showSucessHud {
    [self showSucessHudWithMessage:nil];
}

#pragma mark - *********** show Error **********

-(void)showErrorHudWithMessage:(NSString *)msg {
   
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showErrorWithStatus:msg];

}

-(void)showErrorHud {
    [self showErrorHudWithMessage:nil];
}


#pragma mark - *********** show Info **********

-(void)showInfoHudWithMessage:(NSString *)msg {
   
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showInfoWithStatus:msg];
}

-(void)showTextHudInMiddleWithMessage:(NSString *)msg {
    
    if ([self viewWithTag:JGHudTag]) {
        JGProgressHUD *lastHud = [self viewWithTag:JGHudTag];
        [lastHud dismissAnimated:NO];
    }
    
    JGProgressHUD *HUD = [self jgProgressHud];
    HUD.textLabel.text = msg;
    HUD.position = JGProgressHUDPositionCenter;
    [HUD showInView:self];
    [HUD dismissAfterDelay:2];
}


- (void)showTextHudInBottomWithMessage:(NSString *)msg {
    
    if ([self viewWithTag:JGHudTag]) {
        JGProgressHUD *lastHud = [self viewWithTag:JGHudTag];
        [lastHud dismissAnimated:NO];
    }

    JGProgressHUD *HUD = [self jgProgressHud];
    HUD.textLabel.text = msg;
    HUD.position = JGProgressHUDPositionBottomCenter;
    [HUD showInView:self];
    [HUD dismissAfterDelay:2];
}



-(JGProgressHUD *)jgProgressHud {
    JGProgressHUD *HUD = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];;
    HUD.indicatorView = nil;
    HUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;
    HUD.textLabel.font = kFontX15;
    HUD.tag = JGHudTag;
    return HUD;
}




@end
