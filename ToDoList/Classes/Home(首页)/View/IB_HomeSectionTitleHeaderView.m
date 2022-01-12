//
//  IB_HomeSectionTitleHeaderView.m
//  ImBaby
//
//  Created by zc on 2019/4/16.
//  Copyright © 2019 imbaby.com. All rights reserved.
//

#import "IB_HomeSectionTitleHeaderView.h"
#import "UILabel+Extension.h"
@interface IB_HomeSectionTitleHeaderView()

@property (nonatomic,strong) UILabel *titleL;

@property (nonatomic,strong) UILabel *subTitleL;

@end


@implementation IB_HomeSectionTitleHeaderView


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        _titleL.text = @"天天特惠";
        _subTitleL.text = @"周一更新 天天特价";
    }
    return self;
}

-(void)setupUI {
    
    _titleL = [UILabel labelWithFont:kFontXX16 textColor:[UIColor blackColor]];
    _subTitleL = [UILabel labelWithFont:kFontX14 textColor:[UIColor darkGrayColor]];

    
    [self addSubview:_titleL];
    [self addSubview:_subTitleL];
    
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self);
    }];
    
    [_subTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleL.mas_right).offset(10);
        make.centerY.equalTo(self);
    }];
}

@end
