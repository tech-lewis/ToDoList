//
//  CU_HomeController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_HomeController.h"

@interface CU_HomeController ()

@end

@implementation CU_HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = kLocalLanguage(@"Home_Tab") ;
    //注册切换语言通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
    self.gk_navTitle = kLocalLanguage(@"Home_Tab") ;
}

@end
