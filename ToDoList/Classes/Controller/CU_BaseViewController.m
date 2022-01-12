//
//  CU_BaseViewController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_BaseViewController.h"

@interface CU_BaseViewController ()

@end

@implementation CU_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBACKGROUND_COLOR ;
    self.gk_navShadowColor = [UIColor clearColor] ;
    self.gk_navItemLeftSpace = 0.0f ;
}

//移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
