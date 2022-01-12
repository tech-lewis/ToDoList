//
//  EmptyDataView.m
//  TestEmptyDataView
//
//  Created by zc on 2017/11/11.
//  Copyright © 2017年 com.eenet. All rights reserved.
//

#import "EmptyDataView.h"
#import "Base_Define.h"
#import "UIView+Extension.h"

@interface EmptyDataView()

/**  图片 */
@property (nonatomic,strong) UIImageView *imageView;

/** title */
@property (nonatomic,strong) UILabel *titleL;

/** 副标题 */
@property (nonatomic,strong) UILabel *subTitleL;

/** 按钮 */
@property (nonatomic,strong) UIButton *button;

@end


@implementation EmptyDataView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.alpha = 0;
        self.backgroundColor = kGloableBackgroundColor;
        //        self.imageView.image = [UIImage imageNamed:@"placeholder_dropbox"];
        //        self.titleL.text = @"我是Title";
        ////        self.subTitleL.text = @"我是SubTitle";
        //        [self.button setTitle:@"我是按钮" forState:UIControlStateNormal];
        
        [self.button setBackgroundColor:kNavigationBarBgColor];
        
        [self setupUI];
        
    }
    
    return self;
}

- (void)showEmptyDataView:(BOOL)animated {
    
    [self.superview bringSubviewToFront:self];
    
    [self configerData];
    
    [self setNeedsLayout];
    
    [self superViewCanScorollEnable:NO];
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 1;
        }];
    } else {
        self.alpha = 1;
    }
    
    [self layoutSubviews];
}

-(void)hideEmptyDataView:(BOOL)animated {
    
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = 0;
        }];
    }else{
        self.alpha = 0;
    }
    
    [self superViewCanScorollEnable:YES];
}

-(void)setEmptyDataViewStatusIsShow:(BOOL)isShow {
    if (isShow) {
        [self showEmptyDataView:YES];
    }else {
        [self hideEmptyDataView:YES];
    }
}


-(void)superViewCanScorollEnable:(BOOL)enable {
    if ([self.superview isKindOfClass:[UITableView class]]) {//禁止滚动
        UITableView *tb = (UITableView *)self.superview;
        tb.scrollEnabled = enable;
    }
    
    if ([self.superview isKindOfClass:[UICollectionView class]]) {//禁止滚动
        UICollectionView *view = (UICollectionView *)self.superview;
        view.scrollEnabled = enable;
    }
}

#pragma mark - 数据源方法


-(void)configerData {
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingImageView:)]) {
        
        NSString *imageName = [self.dataSource emptyDataViewSettingImageView:nil];
        
        if (imageName) {
            self.imageView.image = [UIImage imageNamed:imageName];
        }
    }
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingTitle:)]) {
        self.titleL.text = [self.dataSource emptyDataViewSettingTitle:nil];
    }
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingTitleAttribute:)]) {
        self.titleL.attributedText = [self.dataSource emptyDataViewSettingTitleAttribute:self.titleL];
    }
    
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingTitleColor:)]) {
        self.titleL.textColor = [self.dataSource emptyDataViewSettingTitleColor:nil];
    }
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingSubTitle:)]) {
        
        NSString *subTitle = [self.dataSource emptyDataViewSettingSubTitle:nil];
        kDefaultJsonEmptyStringFor(subTitle);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:subTitle];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [paragraphStyle setLineSpacing:5];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [subTitle length])];
        self.subTitleL.attributedText = attributedString;
    }
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingSubTitleColor:)]) {
        self.subTitleL.textColor = [self.dataSource emptyDataViewSettingSubTitleColor:nil];
    }
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingButtonTitle:)]) {
        NSString *title =  [self.dataSource emptyDataViewSettingButtonTitle:nil];
        [self.button setTitle:title forState:UIControlStateNormal];
        self.button.hidden = NO;
    }else {
        self.button.hidden = YES;
    }
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingBackGroundColor:)]) {
        self.backgroundColor = [self.dataSource emptyDataViewSettingBackGroundColor:nil];
    }
    
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingFrame:)]) {
        self.frame = [self.dataSource emptyDataViewSettingFrame:CGRectZero];
    }
    
    
}


#pragma mark - Respoond

-(void)buttonClick {
    
    if ([self.delegate respondsToSelector:@selector(emptyDataViewButtonDidClick)]) {
        [self.delegate emptyDataViewButtonDidClick];
    }
    
}

#pragma mark - setupUI

-(void)setupUI {
    [self addSubview:self.imageView];
    [self addSubview:self.titleL];
    [self addSubview:self.subTitleL];
    [self addSubview:self.button];
    
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    CGFloat screenW = self.width;
    CGFloat screenH = self.height;
    
    CGFloat maxW = screenW * 0.8;
    CGFloat pading = 8;
    
    CGSize maxSize = CGSizeMake(maxW, 300);
    
    CGSize imageSize =  [self.imageView sizeThatFits:CGSizeMake(screenW * 0.35, 300)];
    CGSize titleSize = [self.titleL sizeThatFits:maxSize];
    CGSize subTitleSize = [self.subTitleL sizeThatFits:maxSize];
    CGSize buttonSize = [self.button sizeThatFits:maxSize];
    buttonSize.width += 5;
    
    NSInteger count = 1;
    if (imageSize.height>0) {
        count += 1;
    }
    if (titleSize.height > 0) {
        count += 1;
    }
    if (subTitleSize.height > 0) {
        count += 1;
    }
    
    if (buttonSize.height > 0) {
        count += 1;
    }
    
    CGFloat totalPading = (count-1)*pading;
    
    CGFloat imageX = (screenW - imageSize.width)*0.5;
    CGFloat imageY = (screenH -64 - imageSize.height-titleSize.height - subTitleSize.height-buttonSize.height-totalPading)*0.5;
    
    if ([self.dataSource respondsToSelector:@selector(emptyDataViewSettingTitleYOffet:)]) {
        imageY += [self.dataSource emptyDataViewSettingTitleYOffet:0];
    }
    
    
    CGFloat titleX = (screenW - titleSize.width)*0.5;
    CGFloat titleY = imageY + imageSize.height + pading;
    if (imageSize.height <= 0) {
        titleY -= pading;
    }
    
    CGFloat subTitleX = (screenW - subTitleSize.width)*0.5;
    CGFloat subTitleY = titleY + titleSize.height + pading;
    if (titleSize.height <= 0) {
        subTitleY -= pading;
    }
    
    CGFloat buttonX = (screenW - buttonSize.width)*0.5;
    CGFloat buttonY = subTitleY + subTitleSize.height + pading;
    if (subTitleSize.height <= 0) {
        buttonY -= pading;
    }
    
    if (buttonSize.width >= 0) {//给文字按钮加点间距
        buttonSize.width += pading;
    }
    
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    self.titleL.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    self.subTitleL.frame = CGRectMake(subTitleX, subTitleY, subTitleSize.width, subTitleSize.height);
    self.button.frame = CGRectMake(buttonX, buttonY, buttonSize.width, buttonSize.height);
    
    
}

#pragma mark - getter

-(UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    
    return _imageView;
}

-(UILabel *)titleL {
    if (_titleL == nil) {
        _titleL = [[UILabel alloc]init];
        _titleL.font = [UIFont systemFontOfSize:16];
        _titleL.textColor = [UIColor darkGrayColor];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.numberOfLines = 2;
    }
    
    return _titleL;
}


-(UILabel *)subTitleL {
    if (_subTitleL == nil) {
        _subTitleL = [[UILabel alloc]init];
        _subTitleL.font = [UIFont systemFontOfSize:14];
        _subTitleL.textAlignment = NSTextAlignmentCenter;
        _subTitleL.numberOfLines = 2;
        _subTitleL.textColor = [UIColor darkGrayColor];
    }
    
    return _subTitleL;
}

-(UIButton *)button {
    if (_button == nil) {
        _button = [[UIButton alloc]init];
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.cornerRadius = 3;
        _button.clipsToBounds = YES;
        _button.hidden = YES;
    }
    
    return _button;
}


@end
