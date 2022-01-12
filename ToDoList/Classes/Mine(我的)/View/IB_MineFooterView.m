//
//  IB_MineFooterView.m
//  ImBaby
//
//  Created by zc on 2019/4/16.
//  Copyright © 2019 imbaby.com. All rights reserved.
//

#import "IB_MineFooterView.h"
#import "UIButton+EnlargeTouchArea.h"
#import "UILabel+Extension.h"
#import "UIView+Extension.h"
#import "Base_Define.h"
@interface IB_MineFooterView()

@property (nonatomic,strong) UILabel *titleL;

@property (nonatomic,strong) UIView *bottomView;

/** u */
@property (nonatomic,strong) UIImageView *lineView;

@end


@implementation IB_MineFooterView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setuUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _lineView.frame = CGRectMake(0, 0, self.width, 10);
    
    _titleL.frame = CGRectMake(15, 10, kScreenWidth - 30, 44);
    CGFloat bottomY = CGRectGetMaxY(_titleL.frame);
    _bottomView.frame = CGRectMake(0, bottomY, kScreenWidth, self.height - bottomY);
    
    CGFloat padding = 30;
    CGFloat middPading = 15;
    CGFloat btnW = (kScreenWidth - padding*2 - 3*padding)/4.0;
    CGFloat btnH = (_bottomView.height - middPading-10)/2.0;
    
    for (int i = 0; i < _bottomView.subviews.count; i++) {
        
        UIButton *button = _bottomView.subviews[i];
        
        NSInteger row = i % 4;
        NSInteger col = i / 4;
        CGFloat x = padding + row * (btnW + padding);
        CGFloat y = col*(btnH + middPading);
        button.frame = CGRectMake(x, y, btnW, btnH);
    }
}


-(void)buttonClick:(UIButton *)button {
    
    NSLog(@"点击：@",button.titleLabel.text);
}

#pragma mark - setupUI

-(void)setuUI {
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = kGloableBackgroundColor;
    
    _titleL = [UILabel labelWithFont:kFontXX16 textColor:[UIColor blackColor]];
    _titleL.text = @"常用功能";
    
    _bottomView  = [[UIView alloc]init];
    
    [self addSubview:_lineView];
    [self addSubview:_titleL];
    [self addSubview:_bottomView];
    
    NSArray *titlesArray = @[@"店铺信息",@"使用帮助",@"设置",@"在线客服",@"余额管理",@"退货单"];
    NSArray *imagesArray = @[@"u-home",@"u-help",@"u-set",@"u-fill",@"u-yue",@"u-tuih"];
    
    for (int i = 0; i < titlesArray.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.titleLabel.font = kFontX14;
        button.tag = i;
        [button setTitle:titlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesArray[i]] forState:UIControlStateNormal];
        [button kc_setImagePosition:KCButtonImagePositionTop margin:8];
        [_bottomView addSubview:button];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


@end
