//
//  UITextView+CU_TextViewPlaceHolder.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CU_TextViewPlaceHolder)

/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholderStr;

/**
 *  占位文字字号
 */
@property (nonatomic, strong) UIFont *placeholderFont;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  最大显示字符限制(会自动根据该属性截取文本字符长度)
 */
@property (nonatomic, assign) NSInteger maximumLimit;

/**
 *  右下角字符长度提示(需要设置maximumLimit属性)  默认NO
 */
@property (nonatomic, assign) BOOL characterLengthPrompt;

/**
 *  文本发生改变时回调
 */
- (void)textDidChange:(void(^)(NSString *textStr))handle;

/**
 *  处理系统输入法导致的乱码,如果调用了maximumLimit属性，内部会默认处理乱码
 */
- (void)fixMessyDisplay;

@end

NS_ASSUME_NONNULL_END
