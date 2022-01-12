//
//  UIButton+EnlargeTouchArea.h
//  qixiubaov2
//
//  Created by Chiu on 2017/8/14.
//  Copyright © 2017年 nanxinwang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, KCButtonImagePosition) {
    KCButtonImagePositionLeft = 0,              //图片在左，文字在右，默认
    KCButtonImagePositionRight = 1,             //图片在右，文字在左
    KCButtonImagePositionTop = 2,               //图片在上，文字在下
    KCButtonImagePositionBottom = 3,            //图片在下，文字在上
};


@interface UIButton (EnlargeTouchArea)

- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;


/**
 *  注意：这个方法需要在设置图片和文字之后才生效
 *
 *   图片和文字的间隔
 */
- (void)kc_setImagePosition:(KCButtonImagePosition)postion margin:(CGFloat)margin;

//是否限制最大宽度
- (void)kc_setImagePosition:(KCButtonImagePosition)postion margin:(CGFloat)margin limitMaxW:(BOOL)limit;


/** 统一设置圆角 */
-(void)setCircle;

@end
