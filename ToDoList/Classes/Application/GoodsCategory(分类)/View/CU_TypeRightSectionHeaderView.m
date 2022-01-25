//
//  PRO_TypeRightSectionHeaderView.m
//  QPM_Procurement_iOS
//
//  Created by zc on 2019/3/10.
//  Copyright © 2019 qpm.com. All rights reserved.
//

#import "CU_TypeRightSectionHeaderView.h"
#import "UILabel+Extension.h"
#import "CU_Define.h"
#import "CU_Const.h"
@interface CU_TypeRightSectionHeaderView()


@property (nonatomic,strong) UIButton *arrowBtn;

@property (nonatomic,strong) UIImageView *lineView;

@end


@implementation CU_TypeRightSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        self.titleL.text = @"热门品牌";
    }
    return self;
}

#pragma mark - seutpUI

-(void)setupUI {
    
    _titleL = [UILabel labelWithFont:kFont(16) textColor:[UIColor darkTextColor]];
    
    _arrowBtn = [[UIButton alloc]init];
    _arrowBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_arrowBtn setTitle:@"查看 >" forState:UIControlStateNormal];
    [_arrowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _arrowBtn.hidden = YES;
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = kRGBA_COLOR(235, 195, 75, 1);
    
    [self addSubview:_titleL];
    [self addSubview:_arrowBtn];
    [self addSubview:_lineView];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(@(kSCREEN_WIDTH - 110 - 40 - 30));
    }];
    
    [_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.titleL);
        make.height.equalTo(@3);
        make.width.equalTo(@25);
    }];
}

@end
