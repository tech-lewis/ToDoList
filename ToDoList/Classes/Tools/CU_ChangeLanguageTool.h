//
//  CU_ChangeLanguageTool.h
//  cu
//
//  Created by 钟小麦 on 2019/8/22.
//  Copyright © 2019 NZ. All rights reserved.
//  语言国际化

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CU_ChangeLanguageTool : NSObject

+(NSBundle *)bundle;//获取当前资源文件
+(void)initUserLanguage;//初始化语言文件
+(NSString *)userLanguage;//获取应用当前语言
+(void)setUserlanguage:(NSString *)language;//设置当前语言

@end

NS_ASSUME_NONNULL_END
