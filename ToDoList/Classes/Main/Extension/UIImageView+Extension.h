//
//  UIImageView+Extension.h
//  RecruitStudent_iOS
//
//  Created by zc on 2017/3/5.
//  Copyright © 2017年 com.eenet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/**设置图片使用默认占位图*/
-(void)base_setImageViewWithUrl:(NSString *)url;

/**设置图片带占位图*/
-(void)base_setiamgeViewWithUrl:(NSString *)url andPlaceHolderImageName:(NSString *)imgName;


@end
