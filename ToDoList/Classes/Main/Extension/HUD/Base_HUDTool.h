//
//  QXB_HUDTool.h
//  QiXiuBao_iOS
//
//  Created by zc on 2018/1/26.
//  Copyright © 2018年 qixiubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base_HUDTool : NSObject


/** 添加个非View或控制器调用showLoading方法 */

/** show in windows */
+(void)showLoadingInWindowWithMessage:(NSString *)msg;

/** noral show */
+(void)showLoadingWithMessgae:(NSString *)msg;

+(void)dissmissHud;

+ (void)showTextHudInBottomWithMessage:(NSString *)msg WithView:(UIView *)view;

+(void)showSucessHudWithMessage:(NSString *)msg;

+(void)showInfoHudWithMessage:(NSString *)msg;

@end
