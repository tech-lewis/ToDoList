//
//  UIImage+Extension.h
//  RecruitStudent_iOS
//
//  Created by Gzedu on 2017/3/7.
//  Copyright © 2017年 com.eenet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
//颜色转图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

/**
 绘制带下划线的图片
 
 @param backgroundColor 图片背景色
 @param underlineColor 下划线颜色
 @param rect 图片大小
 @return 带下划线的图片
 */
+ (UIImage *)imageUnderlineWithBackgroundColor:(UIColor *)backgroundColor
                                underlineColor:(UIColor *)underlineColor
                                          rect:(CGRect)rect;

/**
 *  获取图片上一个点的颜色
 *
 *  @param image image
 *
 *  @return 返回点击点的颜色 red green blue
 */

//+ (NSDictionary *)mostColor:(UIImage *)image scale:(CGFloat)scale;

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;
@end
