//
//  CU_MineCell.m
//  cu
//
//  Created by 钟小麦 on 2019/9/1.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_MineCell.h"
#import "CU_MineModel.h"

@interface CU_MineCell()

@property (nonatomic,strong) UIImageView *iconImgView ;
@property (nonatomic,strong) UILabel *titleLab ;

@end

@implementation CU_MineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if(self){
        [self configUI] ;
    }
    return self ;
}

#pragma mark - UI布局
-(void) configUI{
    [self addSubview:self.iconImgView] ;
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self) ;
        make.left.equalTo(self).offset(kAdaptedWidth(16)) ;
    }] ;
    [self addSubview:self.titleLab] ;
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self) ;
        make.left.equalTo(self.iconImgView.mas_right).offset(kAdaptedWidth(15)) ;
    }] ;
}

- (void)setModel:(CU_MineModel *)model{
    _model = model ;
    self.iconImgView.image = [UIImage imageNamed:model.leftImgName] ;
    self.titleLab.text = model.title ;
}

#pragma mark - Getter
-(UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView = ({
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
            //添加图片
            imgView.image = [UIImage imageNamed:@"我的优惠券"];
            imgView.contentMode = UIViewContentModeCenter ;
            imgView ;
        }) ;
    }
    return _iconImgView ;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"商店名称";//内容显示
            label.textColor = kRGB_COLOR(102,102,108);//设置字体颜色
            label.font = [UIFont fontWithName:@"HelveticaNeueLTStd-Lt" size:kAdaptedWidth(14)];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _titleLab ;
}

@end
