//
//  CU_LeftImgTextField.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//  可设置图片与文字间隔的TextField

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CU_LeftImgTextField : UITextField

@property (nonatomic,assign) NSInteger space ;

@property (nonatomic,strong) UIColor *placeholderColor ;

@end

NS_ASSUME_NONNULL_END
