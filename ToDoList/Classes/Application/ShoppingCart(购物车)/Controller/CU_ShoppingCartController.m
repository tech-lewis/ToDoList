//
//  CU_ShoppingCartController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_ShoppingCartController.h"
#import "CU_ChangeLanguageTool.h"
#import "CU_Define.h"
#import "CU_Const.h"

@interface CU_ShoppingCartController ()

@end

@implementation CU_ShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = kLocalLanguage(@"Cart_Tab") ;
    //注册切换语言通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
    self.gk_navTitle = kLocalLanguage(@"Cart_Tab") ;
}

@end
