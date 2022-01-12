//
//  CU_ChangeLanguageTool.m
//  cu
//
//  Created by 钟小麦 on 2019/8/22.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_ChangeLanguageTool.h"
#import "CU_Const.h"
static NSBundle *bundle = nil;

@implementation CU_ChangeLanguageTool

+ ( NSBundle * )bundle{
    
    return bundle;
}

//首次加载的时候先检测语言是否存在
+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *currLanguage = [def valueForKey:kLocalLanguageKey];
    
    if(!currLanguage){
        NSArray *preferredLanguages = [NSLocale preferredLanguages];
        currLanguage = preferredLanguages[0];
        if ([currLanguage hasPrefix:@"en"]) {
            currLanguage = @"en";
        }else if ([currLanguage hasPrefix:@"zh"]) {
            currLanguage = @"zh-Hans";
        }else currLanguage = @"en";
        [def setValue:currLanguage forKey:kLocalLanguageKey];
        [def synchronize];
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
    bundle = [NSBundle mainBundle];//生成bundle
}

//获取当前语言
+(NSString *)userLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *language = [def valueForKey:kLocalLanguageKey];
    
    return language;
}
//设置语言
+(void)setUserlanguage:(NSString *)language{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currLanguage = [userDefaults valueForKey:kLocalLanguageKey];
    if ([currLanguage isEqualToString:language]) {
        return;
    }
    [userDefaults setValue:language forKey:kLocalLanguageKey];
    [userDefaults synchronize];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
}

@end
