//
//  BiDAppDelegate.m
//  ToDoList
//
//  Created by Mark Lewis on 15-4-4.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "BiDAppDelegate.h"
#import "CU_TabBarController.h"
#import "CU_ChangeLanguageTool.h"
#import "GKNavigationBarConfigure.h"
@implementation BiDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
  [self.window makeKeyWindow];
  [self.window makeKeyAndVisible];
  [self configNav] ;//导航栏配置
  //初始化应用语言
  [CU_ChangeLanguageTool initUserLanguage];
  
  CU_TabBarController *vc = [[CU_TabBarController alloc] init] ;
  self.window.rootViewController = vc ;
  return YES;
}

#pragma mark - 设置导航栏
-(void) configNav{
    // 统一设置导航栏样式
    GKNavigationBarConfigure *configure = [GKNavigationBarConfigure sharedInstance];
    [configure setupDefaultConfigure];
    // 设置自定义样式
    configure.backgroundColor = [UIColor whiteColor];
    configure.titleColor = [UIColor blackColor];
    configure.titleFont  = kBoldFont(16);
    configure.backStyle = GKNavigationBarBackStyleBlack ;
    configure.gk_navItemLeftSpace = 8 ;
    configure.gk_navItemRightSpace = 8 ;
}
@end
