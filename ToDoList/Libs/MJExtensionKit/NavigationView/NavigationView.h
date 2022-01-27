//
//  NavigationView.h
//  ToDoList
//
//  Created by MarkLwis on 2022/1/27.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationView : UIView

/// 默认导航栏标题颜色
+ (UIColor *)defaultTitleColor;
/// 默认导航栏标题字体
+ (UIFont *)defaultTitleFont;
/// 默认导航栏背景色
+ (UIColor *)defaultBackgroundColor;
/// 默认导航栏背景图，接受图片名String，图片UIImage
+ (UIImage *)defaultBackgroundImage;
/// 默认导航栏返回按钮图片
+ (NSString *)defaultBackImage;
/// 默认导航栏返回按钮标题
+ (NSString *)defaultBackTitle;

/// 导航栏标题
- (UILabel *)titleLabel;
/// 导航栏背景
- (UIImageView *)backgroundView;

@end
