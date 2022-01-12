//
//  CU_Const.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_Const.h"

#if DEBUG

NSString *const kAppHost = @"";//域名

#elif RELEASE

NSString *const kAppHost = @"";//域名

#endif


#pragma mark - api接口

#pragma mark - 常量
NSString *const kLocalLanguageKey = @"kLocalLanguageKey";//项目语言

#pragma mark - 通知
NSString *const kChangeLanguageNotice = @"kChangeLanguageNotice";//切换语言
