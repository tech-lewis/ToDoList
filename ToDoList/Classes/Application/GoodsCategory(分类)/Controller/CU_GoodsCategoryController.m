//
//  CU_GoodsCategoryController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_GoodsCategoryController.h"

@interface CU_GoodsCategoryController ()

@end

@implementation CU_GoodsCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = kLocalLanguage(@"Category_Tab") ;
    //注册切换语言通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
    self.gk_navTitle = kLocalLanguage(@"Category_Tab") ;
}


@end
