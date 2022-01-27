
//  CU_NavitationViewController.m
//  cu
//
//  Created by zc on 2019/8/24.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_NavitationViewController.h"

@interface CU_NavitationViewController ()

@end

@implementation CU_NavitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0 ) {
        
        viewController.hidesBottomBarWhenPushed = YES;//push到下一级界面，隐藏tabbar
        
    }
    
    
    [super pushViewController:viewController animated:animated ];
}

@end
