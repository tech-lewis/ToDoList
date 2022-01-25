//
//  UIView+Extension.h
// 
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年  All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGSize size;


/**
 *  indicator
 */
- (void)kc_showActivityIndicator;
- (void)kc_hideActivityIndicator;
- (void)kc_setActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style;


/*
 * 显示红点, 默认在右上角
 */
@property (nonatomic, strong) UIFont *kc_badgeFont;
@property (nonatomic, strong) UIColor *kc_badgeColor;
@property (nonatomic, strong) UIColor *kc_badgeBorderColor;
@property (nonatomic, copy) NSString *kc_badgeValue;
@property (nonatomic, strong) UIColor *kc_badgeBackgroundColor;

- (void)kc_setBadgeValue:(NSString *)badgeValue offset:(CGPoint)offset;


//设置圆角
- (void)setCycle;
- (void)setCycle:(CGFloat)radus;

-(void)setBorderWidth:(CGFloat)width borderColor:(UIColor *)color;


+(instancetype)viewWithXibs;

@end
