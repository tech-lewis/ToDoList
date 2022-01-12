//
//  UIButton+EnlargeTouchArea.m
//  qixiubaov2
//
//  Created by Chiu on 2017/8/14.
//  Copyright © 2017年 nanxinwang. All rights reserved.
//

#import "UIButton+EnlargeTouchArea.h"
#import <objc/message.h>

@implementation UIButton(EnlargeTouchArea)

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber *topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint) point withEvent:(UIEvent *) event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}

/**
 *  注意：这个方法需要在设置图片和文字之后才生效
 *
 *   图片和文字的间隔
 */
- (void)kc_setImagePosition:(KCButtonImagePosition)postion margin:(CGFloat)margin {
    
    
    [self kc_setImagePosition:postion margin:margin limitMaxW:NO];
    

}

-(void)kc_setImagePosition:(KCButtonImagePosition)postion margin:(CGFloat)margin limitMaxW:(BOOL)limit {
    
    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGSize labelSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGFloat labelWidth = labelSize.width;
    CGFloat labelHeight = labelSize.height;
    
    CGFloat maxW = self.width;
    
    if (limit && ((labelWidth + imageWidth + margin) > maxW ) && maxW>0) {
         labelWidth = maxW - imageWidth - margin - 10;
    }

    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
    CGFloat imageOffsetY = imageHeight / 2 + margin / 2;//image中心移动的y距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
    CGFloat labelOffsetY = labelHeight / 2 + margin / 2;//label中心移动的y距离
    
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + margin - tempHeight;
    
    switch (postion) {
        case KCButtonImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -margin/2, 0, margin/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, margin/2, 0, -margin/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, margin/2, 0, margin/2);
            break;
            
        case KCButtonImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + margin/2, 0, -(labelWidth + margin/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + margin/2), 0, imageWidth + margin/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, margin/2, 0, margin/2);
            break;
            
        case KCButtonImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
            
        case KCButtonImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
            
        default:
            break;
    }
    
}


-(void)setCircle {
    self.layer.cornerRadius = 3;
    self.clipsToBounds = YES;
}

@end
