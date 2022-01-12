//
//  IB_MineFooterView.m
//  ImBaby
//
//  Created by zc on 2019/4/16.
//  Copyright © 2019 imbaby.com. All rights reserved.
//


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
    
    _topView.frame = CGRectMake(0, 10, self.width, self.topView.showBranch ? 133 : 88);
    _titleL.frame = CGRectMake(15, CGRectGetMaxY(_topView.frame)+1, kScreenWidth - 30, 44);
    CGFloat bottomY = CGRectGetMaxY(_titleL.frame);
    _bottomView.frame = CGRectMake(0, bottomY, kScreenWidth, self.height - bottomY);
    
    CGFloat padding = kScreenWidth <= 375 ? 15 : 20;
    CGFloat middPading = kScreenWidth < 375 ? 8: 10;
    
    if (kScreenWidth < 375) {
        padding = 20;
    }
    
    CGFloat btnW = (kScreenWidth - padding*2 - 3*padding)/4.0;
    CGFloat btnH = (_bottomView.height - middPading-20)/2.0;
    
    
    for (int i = 0; i < _bottomView.subviews.count; i++) {
        
        UIButton *button = _bottomView.subviews[i];
        
        NSInteger row = i % 4;
        NSInteger col = i / 4;
        CGFloat x = padding + row * (btnW + padding);
        CGFloat y = col*(btnH + middPading);
        button.frame = CGRectMake(x, y, btnW, btnH);
    }
}


-(void)setDelegate:(id<IB_MineFooterViewDelegate,IB_MineFooterListViewDelegate>)delegate {
    _delegate = delegate;
    self.topView.delegate = delegate;
}

-(void)buttonClick:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(IB_MineFooterViewDidClickMenuBtn:)]) {
        [self.delegate IB_MineFooterViewDidClickMenuBtn:button.titleLabel.text];
    }
}

#pragma mark - setupUI

-(void)setuUI {
    
    _lineView = [[UIImageView alloc]init];
    _lineView.backgroundColor = kGloableBackgroundColor;
    
    _titleL = [UILabel labelWithFont:kFontXX16 textColor:[UIColor blackColor]];
    _titleL.text = @"常用功能";
    
    _bottomView  = [[UIView alloc]init];
    
    _topView = [[NSBundle mainBundle]loadNibNamed:@"IB_MineFooterListView" owner:nil options:nil].firstObject;
    
    [self addSubview:_topView];
    [self addSubview:_lineView];
    [self addSubview:_titleL];
    [self addSubview:_bottomView];
    
    
    NSArray *titlesArray = @[kShopInfoKey,kHelpKey,kSettingKey,kPayKey,kBalanceKey,kBankKey,kRefundKey,kLogout];
    NSArray *imagesArray = @[@"u-home",@"u-help",@"u-set",@"u_pay",@"u_yu",@"u_bank",@"u-tuih",@"u_lougout"];
    
    for (int i = 0; i < titlesArray.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.titleLabel.font = kScreenWidth < 375 ? kFontM11 : kFontS13;
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
