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
@property (nonatomic, assign) CGSize size;
//设置圆角
-(void)setCycle;
-(void)setCycle:(CGFloat)radus;

-(void)setBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
