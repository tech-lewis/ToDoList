//
//  CU_ShoppingCartCell.m
//  cu
//
//  Created by 钟小麦 on 2019/8/25.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_ShoppingCartCell.h"
#import "BEMCheckBox.h"
#import "NumberCalculate.h"

@interface CU_ShoppingCartCell()

@property (nonatomic,strong) UIView *topView ;
@property (nonatomic,strong) BEMCheckBox *checkBox ;//勾选框
@property (nonatomic,strong) UIImageView *imgView ;//商品图片
@property (nonatomic,strong) UILabel *titleLab ;//商品标题
@property (nonatomic,strong) UILabel *tipLab ;//商品属性
@property (nonatomic,strong) UILabel *dollarPriceLab ;//美元价格
@property (nonatomic,strong) UILabel *priceLab ;//人民币价格
@property (nonatomic,strong) UILabel *pointLab ;//积分

@property (nonatomic,strong) UIView *botView ;
@property (nonatomic,strong) NumberCalculate *numberCalculate ;//数量加减控件

@end

@implementation CU_ShoppingCartCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if(self){
        [self configUI] ;
    }
    return self ;
}

#pragma mark - UI布局
-(void) configUI{
    //顶部
    [self addSubview:self.topView] ;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self) ;
        make.height.mas_equalTo(kAdaptedWidth(110)) ;
    }] ;
    [self.topView addSubview:self.checkBox] ;
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView) ;
        make.left.equalTo(self.topView).offset(kAdaptedWidth(15)) ;
        make.size.mas_equalTo(CGSizeMake(kAdaptedWidth(20), kAdaptedWidth(20))) ;
    }] ;
    [self.topView addSubview:self.imgView] ;//商品图片
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView) ;
        make.left.equalTo(self.checkBox.mas_right).offset(kAdaptedWidth(10)) ;
        make.size.mas_equalTo(CGSizeMake(kAdaptedWidth(90), kAdaptedWidth(90))) ;
    }] ;
    [self.topView addSubview:self.titleLab] ;//商品标题
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_top).offset(-kAdaptedWidth(2)) ;
        make.left.equalTo(self.imgView.mas_right).offset(kAdaptedWidth(10)) ;
        make.right.equalTo(self.topView).offset(-kAdaptedWidth(15)) ;
    }] ;
    [self.topView addSubview:self.tipLab] ;//商品属性
    [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab) ;
        make.top.equalTo(self.titleLab.mas_bottom).offset(kAdaptedWidth(2)) ;
    }] ;
    [self.topView addSubview:self.pointLab] ;//积分
    [self.pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab) ;
        make.top.equalTo(self.tipLab.mas_bottom).offset(kAdaptedWidth(6)) ;
    }] ;
    [self.topView addSubview:self.dollarPriceLab] ;//美元价格
    [self.dollarPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab) ;
        make.top.equalTo(self.pointLab.mas_bottom).offset(kAdaptedWidth(2)) ;
    }] ;
    [self.topView addSubview:self.priceLab] ;//人民币价格
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dollarPriceLab) ;
        make.left.equalTo(self.dollarPriceLab.mas_right) ;
    }] ;

    //底部数量
    [self addSubview:self.botView] ;
    [self.botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom) ;
        make.left.right.bottom.equalTo(self) ;
        make.height.mas_equalTo(kAdaptedWidth(40)) ;
    }] ;
    [self.botView addSubview:self.numberCalculate] ;
    [self.numberCalculate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.botView) ;
        make.right.equalTo(self.botView).offset(-kAdaptedWidth(16)) ;
        make.size.mas_equalTo(CGSizeMake(kAdaptedWidth(100), kAdaptedWidth(26))) ;
    }] ;
}

#pragma mark - Getter
- (UIView *)topView{
    if (!_topView) {
        _topView = [UIView new] ;
        _topView.backgroundColor = [UIColor whiteColor] ;
    }
    return _topView ;
}
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
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
            //添加图片
            imgView.image = [UIImage imageNamed:@"imgt02"];

            imgView ;
        }) ;
    }
    return _imgView ;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"Mi 11’ 512GB/WLAN Portab-le tablet p1209";//内容显示
            label.textColor = kRGB_COLOR(42,42,44);//设置字体颜色
            label.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:kAdaptedWidth(12)];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 2; //行数
            
            label ;
        }) ;
    }
    return _titleLab ;
}
-(UILabel *)tipLab{
    if (!_tipLab) {
        _tipLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"Official standard,512GB";//内容显示
            label.textColor = kRGB_COLOR(193,193,193);//设置字体颜色
            label.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:kAdaptedWidth(10)];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _tipLab ;
}
-(UILabel *)pointLab{
    if (!_pointLab) {
        _pointLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"Points  6600";//内容显示
            label.textColor = kRGB_COLOR(238,191,63);//设置字体颜色
            label.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:kAdaptedWidth(11)];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _pointLab ;
}
-(UILabel *)dollarPriceLab{
    if (!_dollarPriceLab) {
        _dollarPriceLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
//            label.text = @"NZ$ 66.00 / ";//内容显示
            label.textColor = kRGB_COLOR(42,42,44);//设置字体颜色
            label.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:kAdaptedWidth(15)];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _dollarPriceLab ;
}
-(UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"¥55.00";//内容显示
            label.textColor = kRGB_COLOR(93,193,193);//设置字体颜色
            label.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Bd" size:kAdaptedWidth(11)];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _priceLab ;
}

- (UIView *)botView{
    if (!_botView) {
        _botView = [UIView new] ;
        _botView.backgroundColor = [UIColor whiteColor] ;
    }
    return _botView ;
}
- (NumberCalculate *)numberCalculate{
    if (!_numberCalculate) {
        _numberCalculate=[[NumberCalculate alloc]initWithFrame:CGRectMake(0, 0, kAdaptedWidth(100), kAdaptedWidth(26))];
        _numberCalculate.baseNum=@"2";
        _numberCalculate.multipleNum=2;//数值增减基数（倍数增减） 默认1的倍数增减
        _numberCalculate.minNum=2;
        _numberCalculate.maxNum=10;//最大值
        _numberCalculate.hidBorder = YES ;
        _numberCalculate.resultNumber = ^(NSString *number) {
            NSLog(@"%@>>>resultBlock>>",number);
        };
    }
    return _numberCalculate ;
}

@end
