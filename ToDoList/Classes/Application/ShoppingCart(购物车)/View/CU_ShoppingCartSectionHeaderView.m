//
//  CU_ShoppingCartSectionHeaderView.m
//  cu
//
//  Created by 钟小麦 on 2019/9/1.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_ShoppingCartSectionHeaderView.h"
#import "BEMCheckBox.h"

@interface CU_ShoppingCartSectionHeaderView()

@property (nonatomic,strong) BEMCheckBox *checkBox ;//勾选框
@property (nonatomic,strong) UIImageView *shopIconImgView ;
@property (nonatomic,strong) UILabel *shopNameLab ;
@property (nonatomic,strong) UIImageView *arrowImgView ;

@end

@implementation CU_ShoppingCartSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI] ;
    }
    return self;
}

#pragma mark - UI布局
-(void) configUI{
    [self addSubview:self.checkBox] ;
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self) ;
        make.left.equalTo(self).offset(kAdaptedWidth(15)) ;
        make.size.mas_equalTo(CGSizeMake(kAdaptedWidth(20), kAdaptedWidth(20))) ;
    }] ;
    [self addSubview:self.shopIconImgView] ;
    [self.shopIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self) ;
        make.left.equalTo(self.checkBox.mas_right).offset(kAdaptedWidth(8)) ;
        make.size.mas_equalTo(CGSizeMake(kAdaptedWidth(15), kAdaptedWidth(15))) ;
    }] ;
    [self addSubview:self.shopNameLab] ;
    [self.shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self) ;
        make.left.equalTo(self.shopIconImgView.mas_right).offset(kAdaptedWidth(8)) ;
    }] ;
    [self addSubview:self.arrowImgView] ;
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self) ;
        make.left.equalTo(self.shopNameLab.mas_right).offset(kAdaptedWidth(8)) ;
    }] ;
}

#pragma mark - Getter
-(BEMCheckBox *)checkBox{
    if (!_checkBox) {
        _checkBox = [[BEMCheckBox alloc] init] ;
        _checkBox.boxType = BEMBoxTypeCircle ;
        _checkBox.onAnimationType = BEMAnimationTypeFlat ;
        _checkBox.offAnimationType = BEMAnimationTypeFlat ;
        _checkBox.tintColor = [UIColor lightGrayColor];
        _checkBox.onTintColor = kRGB_COLOR(238,191,63);
        _checkBox.onFillColor = kRGB_COLOR(238,191,63);
        _checkBox.onCheckColor = [UIColor whiteColor] ;
        _checkBox.lineWidth = 1 ;
        _checkBox.on = YES ;
    }
    return _checkBox ;
}
-(UIImageView *)shopIconImgView{
    if (!_shopIconImgView) {
        _shopIconImgView = ({
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
            //添加图片
            imgView.image = [UIImage imageNamed:@"tab_shop_s"];

            imgView ;
        }) ;
    }
    return _shopIconImgView ;
}
-(UILabel *)shopNameLab{
    if (!_shopNameLab) {
        _shopNameLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"商店名称";//内容显示
            label.textColor = kRGB_COLOR(42, 42, 44);//设置字体颜色
            label.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:kAdaptedWidth(14)];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _shopNameLab ;
}
-(UIImageView *)arrowImgView{
    if (!_arrowImgView) {
        _arrowImgView = ({
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
            //添加图片
            imgView.image = [UIImage imageNamed:@"rightArrow"];
            
            imgView ;
        }) ;
    }
    return _arrowImgView ;
}

@end
