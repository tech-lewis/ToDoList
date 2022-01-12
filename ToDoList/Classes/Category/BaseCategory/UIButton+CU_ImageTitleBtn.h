//
//  UIButton+CU_ImageTitleBtn.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//  带图片按钮分类

#import <UIKit/UIKit.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, GLButtonEdgeInsetsStyle) {
    GLButtonEdgeInsetsStyleTop, // image在上，label在下
    GLButtonEdgeInsetsStyleLeft, // image在左，label在右
    GLButtonEdgeInsetsStyleBottom, // image在下，label在上
    GLButtonEdgeInsetsStyleRight // image在右，label在左
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (CU_ImageTitleBtn)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END