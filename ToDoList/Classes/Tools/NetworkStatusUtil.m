//
//  NetworkStatusUtil.m
//  Trendpower
//
//  Created by HTC on 15/4/30.
//  Copyright (c) 2015年 trendpower. All rights reserved.
//

#import "NetworkStatusUtil.h"
#import "AFNetworkReachabilityManager.h"

@implementation NetworkStatusUtil

+ (void)startMonitoringNetworkStatus
{
    //网络
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
//        HUDUtil *hud = [HUDUtil sharedHUDUtil];
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                DLog(@"正在使用WiFi网络");
//                [hud showTextJGHUDWithStyle:JGProgressHUDStyleDark interactionType:JGProgressHUDInteractionTypeBlockNoTouches zoom:NO dim:NO shadow:NO text:@"正在使用WiFi网络" font:nil position:JGProgressHUDPositionBottomCenter marginInsets:UIEdgeInsetsMake(0, 0, 55, 0) delay:1.6 inView:[UIApplication sharedApplication].keyWindow];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
              {
                    DLog(@"正在使用移动网络");
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        NSString * stae = [self getNetWorkStates];
//                        [hud showTextJGHUDWithStyle:JGProgressHUDStyleDark interactionType:JGProgressHUDInteractionTypeBlockNoTouches zoom:NO dim:NO shadow:NO text:[NSString stringWithFormat:@"正在使用%@网络",stae] font:nil position:JGProgressHUDPositionBottomCenter marginInsets:UIEdgeInsetsMake(0, 0, 55, 0) delay:1.6 inView:[UIApplication sharedApplication].keyWindow];
                    });
              }
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //[hud showAlertViewWithTitle:@"提示" mesg:@"当前没有网络连接" cancelTitle:nil confirmTitle:@"确认" tag:0];
                DLog(@"当前没有网络连接");
                break;
            default:
                DLog(@"未知网络");
                break;
        }
        
    }];
    

}

/**
 *  此方法存在一定的局限性，比如当状态栏被隐藏的时候，无法使用此方法
 */
+(NSString *)getNetWorkStates{

    
   AFNetworkReachabilityStatus status  = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    
    NSString *state = [[NSString alloc]init];
     switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            state = @"WIFI";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            state = @"移动网";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            //[hud showAlertViewWithTitle:@"提示" mesg:@"当前没有网络连接" cancelTitle:nil confirmTitle:@"确认" tag:0];
            state = @"无网络";
            break;
        default:
            state = @"无网络";
            DLog(@"未知网络");
            break;
    }
    
    
    //根据状态选择
    return state;
}

/**
 *  检查网络联通性
 */
+ (BOOL)isReachable {
    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWWAN] || [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
}

+ (BOOL)isReachableViaWWAN {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN;
}

+ (BOOL)isReachableViaWiFi {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}

@end
