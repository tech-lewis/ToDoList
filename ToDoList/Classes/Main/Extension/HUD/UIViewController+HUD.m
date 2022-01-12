//
//  UIViewController+HUD.m
//  OucOclass
//
//  Created by zc on 2017/6/21.
//  Copyright © 2017年 eenet. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "UIView+HUD.h"

@implementation UIViewController (HUD)

#pragma mark - *********** show Lodign **********
-(void)showLoadingHud {
    [self.view showLoadingHudWithMessage:nil];
}

-(void)showLoadingHudWithMessage:(NSString *)msg {
    [self.view showLoadingHudWithMessage:msg];
}

/** showLoding-InWindow  */

-(void)showLoadingInWindow {
    [self showLoadingInWindowWithMessage:nil];
}

-(void)showLoadingInWindowWithMessage:(NSString *)msg {
    [self.view showLoadingInWindowWithMessage:msg];
}

#pragma mark - *********** show Dismiss **********

-(void)dissmissHud {
    [self.view dissmissHud];
}

#pragma mark - *********** show Sucess **********

-(void)showSucessHud {
    [self.view showSucessHud];
}
-(void)showSucessHudWithMessage:(NSString *)msg {
    [self.view showSucessHudWithMessage:msg];
}

-(void)showSucessHudWithMessage:(NSString *)msg completion:(void(^)(void))finishBlock {
    [self.view showSucessHudWithMessage:msg completion:finishBlock];
}

#pragma mark - *********** show Error **********

-(void)showErrorHud {
    [self.view showErrorHud];
}
-(void)showErrorHudWithMessage:(NSString *)msg {
    [self.view showErrorHudWithMessage:msg];
}


#pragma mark - *********** show Info **********

-(void)showInfoHudWithMessage:(NSString *)msg {
    [self.view showInfoHudWithMessage:msg];
    
}

-(void)showTextHudInBottomWithMessage:(NSString *)msg {
    [self.view showTextHudInBottomWithMessage:msg];
}

-(void)showTextHudInMiddleWithMessage:(NSString *)msg {
    [self.view showTextHudInMiddleWithMessage:msg];
}

@end
