//
//  CU_SellerShopController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_SellerShopController.h"

@interface CU_SellerShopController ()

@end

@implementation CU_SellerShopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = kLocalLanguage(@"Shop_Tab") ;
    //注册切换语言通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
    self.gk_navTitle = kLocalLanguage(@"Shop_Tab") ;
}

@end
