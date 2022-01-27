//
//  UILabel+Extension.m
//  QiXiuBao_iOS
//
//  Created by zc on 2018/1/18.
//  Copyright © 2018年 qixiubao.com. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+(instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.textColor = color;
    return label;
}

@end
