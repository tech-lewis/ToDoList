
//
//  QXB_HUDTool.m
//  QiXiuBao_iOS
//
//  Created by zc on 2018/1/26.
//  Copyright © 2018年 qixiubao.com. All rights reserved.
//

#import "Base_HUDTool.h"
#import "SVProgressHUD.h"
#import "JGProgressHUD.h"

@implementation Base_HUDTool

+(void)showLoadingInWindowWithMessage:(NSString *)msg {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumSize:CGSizeMake(80, 80)];
    [SVProgressHUD showWithStatus:msg];
    
}

/** noral show */
+(void)showLoadingWithMessgae:(NSString *)msg {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumSize:CGSizeMake(80, 80)];
    [SVProgressHUD showWithStatus:msg];
}

+(void)dissmissHud {
    [SVProgressHUD dismiss];
}

+ (void)showTextHudInBottomWithMessage:(NSString *)msg WithView:(UIView *)view {
    
    JGProgressHUD *HUD = [self jgProgressHud];
    HUD.textLabel.text = msg;
    HUD.position = JGProgressHUDPositionBottomCenter;
    [HUD showInView:view];
    [HUD dismissAfterDelay:2];
}

+(void)showSucessHudWithMessage:(NSString *)msg {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showSuccessWithStatus:msg];
}

+(void)showInfoHudWithMessage:(NSString *)msg {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showInfoWithStatus:msg];
}



+(JGProgressHUD *)jgProgressHud {
    JGProgressHUD *HUD = [[JGProgressHUD alloc]initWithStyle:JGProgressHUDStyleDark];;
    HUD.indicatorView = nil;
    HUD.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;
    HUD.textLabel.font = kFontX15;
    return HUD;
}

@end
