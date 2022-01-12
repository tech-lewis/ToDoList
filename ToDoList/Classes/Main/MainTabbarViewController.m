//
//  QXB_TabbarViewController.m
//  QiuXiuBao_iOS
//
//  Created by zc on 2017/11/13.
//  Copyright © 2017年 qixiubao.com. All rights reserved.
//

//vc
#import "MainTabbarViewController.h"
#import "MainNavigationViewController.h"

#import "IB_HomeViewController.h"
#import "IM_TypeController.h"
#import "IM_ShopCarController.h"
#import "IB_MineViewController.h"

#import "Base_TabbarViewController.h"
//#import "PRO_TypeViewController.h"

@interface MainTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation MainTabbarViewController

-(instancetype)init {
    
    MainNavigationViewController *vc1 =  [self addChildVcIs:[[IB_HomeViewController alloc]init]];
    MainNavigationViewController *vc5 = [self addChildVcIs:[[IM_TypeController alloc]init] ];
    MainNavigationViewController *vc2 = [self addChildVcIs:[[IM_ShopCarController alloc]init] ];
    MainNavigationViewController *vc3 =  [self addChildVcIs:[[IB_MineViewController alloc]init]];
    NSArray *viewControllers = @[vc1,vc5,vc2,vc3];

    self = [MainTabbarViewController tabBarControllerWithViewControllers:viewControllers tabBarItemsAttributes:[self tabBarItemsAttributesForController]];
    self.delegate = self;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customizeTabBarAppearance:self];
    
    self.tabBar.backgroundColor = kMainColor;
}

/***********添加子控制器*************/
- (MainNavigationViewController *)addChildVcIs:(UIViewController *)vc
{
    Base_BaseViewController *bsVc = (Base_BaseViewController *)vc;
    //创建导航控制器
    MainNavigationViewController
    *nav = [[MainNavigationViewController alloc]initWithRootViewController:bsVc];
    
//    [nv pushViewController:bsVc animated:YES];

    return  nav;
}


- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"首页",
                                                 CYLTabBarItemImage : @"solidHome",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : [UIImage imageNamed:@"solidHome_s"], /* NSString and UIImage are supported*/
                                                 };
    
    //PRO_TypeViewController
    
    NSDictionary *typeTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"分类",
                                                  CYLTabBarItemImage : @"solidHome",
                                                  CYLTabBarItemSelectedImage : [UIImage imageNamed:@"solidHome_s"],
                                                  
                                                  };
                            
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"购物车",
                                                 CYLTabBarItemImage : @"solidHome",
                                                 CYLTabBarItemSelectedImage : [UIImage imageNamed:@"solidHome_s"],
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的",
                                                  CYLTabBarItemImage : @"solidHome",
                                                  CYLTabBarItemSelectedImage : [UIImage imageNamed:@"solidHome_s"],
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       typeTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}


/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kRGB_COLOR(17, 85, 164);
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
   
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];

    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    
    if ([control cyl_isTabButton]) {
        //更改红标状态
//        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
//            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
//        } else {
//            [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
//        }
        
        animationView = [control cyl_tabImageView];
    }
    
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    }
    
//    if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
//        [self addScaleAnimationOnView:animationView repeatCount:1];
//    } else {
//        [self addRotateAnimationOnView:animationView];
//    }
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

@end
