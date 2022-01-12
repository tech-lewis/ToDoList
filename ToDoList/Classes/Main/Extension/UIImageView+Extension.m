//
//  UIImageView+Extension.m
//  RecruitStudent_iOS
//
//  Created by zc on 2017/3/5.
//  Copyright © 2017年 com.eenet. All rights reserved.
//

#import "UIImageView+Extension.h"
#import "Base_Define.h"
#import "UIImageView+WebCache.h"
// #import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Extension)

- (void)base_setImageViewWithUrl:(NSString *)url
{
    [self base_setiamgeViewWithUrl:url andPlaceHolderImageName:nil];
}

-(void)base_setiamgeViewWithUrl:(NSString *)url andPlaceHolderImageName:(NSString *)imgName
{
    if ([url isKindOfClass:[NSNull class]]) {
        url = @"";
    }
    
    NSURL *nsurl = [NSURL URLWithString:url];
    
    UIImage *image;
    
    if (imgName) {
        image = [UIImage imageNamed:imgName];
    }else {
        image = [UIImage imageNamed:kImagePlaceholder];
    }
    
   
    [self setImageWithURL:nsurl placeholderImage:image];
}

@end
