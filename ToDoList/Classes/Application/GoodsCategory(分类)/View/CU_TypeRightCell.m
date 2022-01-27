//
//  PRO_TypeRightTableViewCell.m
//  QPM_Procurement_iOS
//
//  Created by zc on 2019/3/10.
//  Copyright © 2019 qpm.com. All rights reserved.
//

#import "CU_TypeRightCell.h"
#import "UILabel+Extension.h"
#import "CU_Define.h"
#import "CU_Const.h"
@interface CU_TypeRightCell()

@property (nonatomic,strong) UIImageView *lineView;

@end


@implementation CU_TypeRightCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        
//        self.iconImagView.backgroundColor = kRandonColor;
//        self.titleL.text = @"电池";
        
        _iconImagView.image = [UIImage imageNamed:@"u-home"];
        _titleL.text = @"短外套";
        
    }
    return self;
}


#pragma mark - setupUI

-(void)setupUI {
    
    
    _titleL = [UILabel labelWithFont:kFont(12) textColor:[UIColor blackColor]];
    _titleL.textAlignment = NSTextAlignmentCenter;
    _titleL.numberOfLines = 2;
    
    _iconImagView = [[UIImageView alloc]init];
    _iconImagView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    [self.contentView addSubview:_titleL];
    [self.contentView addSubview:_iconImagView];
    
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-0);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@30);
    }];
    
    [_iconImagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.6);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.titleL.mas_top).offset(-5);
    }];
}

@end
