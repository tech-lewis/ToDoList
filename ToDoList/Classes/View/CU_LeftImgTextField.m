//
//  CU_LeftImgTextField.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_LeftImgTextField.h"
#import "CU_Define.h"
@implementation CU_LeftImgTextField

-(void)setSpace:(NSInteger)space{
    _space = space ;
    [self setNeedsLayout] ;
    [self layoutIfNeeded] ;
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, self.space, 0);
    
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, self.space, 0);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15; //像右边偏15
    return iconRect;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor ;
    [self setValue:kRGB_COLOR(170, 174, 171) forKeyPath:@"_placeholderLabel.textColor"];
}

@end
