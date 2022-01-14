//
//  CU_MineHeaderView.m
//  cu
//
//  Created by 钟小麦 on 2019/9/1.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_MineHeaderView.h"

@interface CU_MineHeaderView()

@end

@implementation CU_MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI] ;
    }
    return self;
}

#pragma mark - UI布局
-(void) configUI{
    self.backgroundColor = [UIColor redColor] ;
}

#pragma mark - Getter

@end
