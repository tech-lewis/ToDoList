//
//  CU_TabBarController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_TabBarController.h"
#import "UINavigationController+GKCategory.h"
#import "CU_Const.h"
#import "CU_Define.h"
#import "CU_HomeController.h"
//#import "CU_GoodsCategoryController.h"
//#import "CU_SellerShopController.h"
//#import "CU_ShoppingCartController.h"
#import "MusicListViewController.h"
#import "CU_MineController.h"
#import "CU_NavitationViewController.h"
@interface CU_TabBarController ()<UITabBarControllerDelegate>

@end

@implementation CU_TabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  [UITabBar appearance].barTintColor = [UIColor whiteColor];
  [UITabBar appearance].translucent = NO ;
  self.delegate = self ;
  // barTintColor
  
  UINavigationController *todoNav = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
  [self addChildVcIs:todoNav.viewControllers.firstObject WithTitle:@"" andImage:@"tab_home" andSelectImage:@"tab_home_s"];
  // [self addChildVcIs:[[UITableViewController alloc]init] WithTitle:@"" andImage:@"tab_shop" andSelectImage:@"tab_shop_s"];
  [self addChildVcIs:[[UITableViewController alloc]init] WithTitle:@"" andImage:@"tab_category" andSelectImage:@"tab_category_s"];
  [self addChildVcIs:[[CU_HomeController alloc]init] WithTitle:@"" andImage:@"tab_cart" andSelectImage:@"tab_cart_s"];
  [self addChildVcIs:[[CU_MineController alloc]init] WithTitle:@"" andImage:@"tab_mine" andSelectImage:@"tab_mine_s"];
  
}

#pragma mark-添加子控制器
/***********添加子控制器*************/
- (void)addChildVcIs:(UIViewController *)vc WithTitle:(NSString *)title andImage:(NSString *)image andSelectImage:(NSString *)selectImage {
    
    UINavigationController *nav = [self creatChildVcIs:vc WithTitle:title andImage:image andSelectImage:selectImage];
    
    [self addChildViewController:nav];
}


-(UINavigationController *)creatChildVcIs:(UIViewController *)vc WithTitle:(NSString *)title andImage:(NSString *)image andSelectImage:(NSString *)selectImage {
    //    vc.navigationController.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.title = title ;
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    
    //文字样式默认
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //文字样式选中
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrSelected[NSForegroundColorAttributeName] = kRGB_SIXTEEN(0x333333);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    [item setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    //创建导航控制器
    CU_NavitationViewController *nav = [CU_NavitationViewController rootVC:vc translationScale:NO];
    
    return nav;
}
-(void)creatChildVcIs:(UIViewController *)vc WithTitle:(NSString *)title andImage:(NSString *)image andSelectImage:(NSString *)selectImage andNav:(UINavigationController *)nv
{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    //设置文字样式
    NSMutableDictionary *textColor = [NSMutableDictionary dictionary];
    textColor[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //文字被选择的样式
    NSMutableDictionary *selectTextColor = [NSMutableDictionary dictionary];
    
    selectTextColor[NSForegroundColorAttributeName] = kMAIN_COLOR;
    
    [vc.tabBarItem setTitleTextAttributes:textColor forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:selectTextColor forState:UIControlStateSelected];
    [nv setViewControllers:@[vc] animated:YES];
}




-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//     CU_LoginModel *account = [CU_LoginModel AccountModel] ;
//    if (account==nil && viewController == [tabBarController.viewControllers objectAtIndex:4]) {
//        //点击我的，未登录
//        CU_LoginController *loginVC = [[CU_LoginController alloc] init] ;
//        loginVC.loginCallBackBlock = ^{
//            tabBarController.selectedIndex = 4;
//        } ;
//        UINavigationController *nav = [UINavigationController rootVC:loginVC translationScale:NO];
//        nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        [self presentViewController:nav animated:YES completion:nil] ;
//        return NO;
//    }
    return YES ;
}
@end
