//
//  IB_HomeBannerCell.m
//  ImBaby
//
//  Created by zc on 2019/4/16.
//  Copyright © 2019 imbaby.com. All rights reserved.
//

#import "IB_HomeBannerCell.h"
#import "SDCycleScrollView.h"
#import "Base_Define.h"
@implementation IB_HomeBannerCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = kRandonColor;
        
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI

-(void)setupUI {
 
    SDCycleScrollView *cycleView = [[SDCycleScrollView alloc]init];
   
    [self.contentView addSubview:cycleView];
    
    cycleView.imageURLStringsGroup =  @[
                                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1555437872180&di=0bbd3813f570e61cc7d78634abd4c943&imgtype=0&src=http%3A%2F%2Fpic.90sjimg.com%2Fback_pic%2F00%2F00%2F69%2F40%2F68995aa9c702958474e17146043a924a.jpg",
                                      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1555437872180&di=ce060a650d4d91626c5e297f27b6b84f&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01093a59a8c918a801211d254920fa.jpg%402o.jpg",
                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1555437872180&di=4c3c1e9f12a0ecaa87ef76ef2d41d147&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01cc2e5947ddeca8012193a3eabef4.jpg%402o.jpg"
                                      
                                      ];
    
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
}

@end
