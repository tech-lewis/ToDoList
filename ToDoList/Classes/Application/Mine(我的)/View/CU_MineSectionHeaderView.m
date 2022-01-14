//
//  CU_MineSectionHeaderView.m
//  cu
//
//  Created by 钟小麦 on 2019/9/1.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_MineSectionHeaderView.h"
#import "CU_ChangeLanguageTool.h"
#import "CU_Define.h"
#import "CU_Const.h"
@interface CU_MineSectionHeaderView()

@property (nonatomic,strong) UIView *cornerView ;//圆角视图
@property (nonatomic,strong) UILabel *titleLab ;

@end

@implementation CU_MineSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI] ;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews] ;
    //得到view的遮罩路径
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cornerView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8,8)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.cornerView.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.cornerView.layer.mask = maskLayer;
}

#pragma mark - UI布局
-(void) configUI{
    [self addSubview:self.cornerView] ;
    [self.cornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kAdaptedWidth(15)) ;
        make.left.right.bottom.equalTo(self) ;
    }] ;
    [self.cornerView addSubview:self.titleLab] ;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cornerView) ;
        make.left.equalTo(self.cornerView).offset(kAdaptedWidth(16)) ;
    }] ;
}

#pragma mark - Getter
- (UIView *)cornerView{
    if (!_cornerView) {
        _cornerView = [UIView new] ;
        _cornerView.backgroundColor = kRGB_COLOR(64,64,64) ;
    }
    return _cornerView ;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = kLocalLanguage(@"Mine_Myservice");//内容显示
            label.textColor = kRGB_COLOR(246,196,61);//设置字体颜色
            label.font = [UIFont fontWithName:@"HelveticaNeueLTPro-Roman" size:kAdaptedWidth(15)];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _titleLab ;
}

@end
