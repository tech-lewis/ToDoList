//
//  PRO_TypeLeftTableViewCell.m
//  QPM_Procurement_iOS
//
//  Created by zc on 2019/3/8.
//  Copyright © 2019 qpm.com. All rights reserved.
//

#import "CU_TypeLeftTableViewCell.h"
#import "CU_GoodsCategoryModel.h"
#import "UILabel+Extension.h"
#import "CU_Define.h"

@interface CU_TypeLeftTableViewCell()

@property (nonatomic,strong) UIImageView *bgView;

@property (nonatomic,strong) UIImageView *leftLineView;

@property (nonatomic,strong) UILabel *titleL;

@end


@implementation CU_TypeLeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
        self.titleL.text = @"女装";
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)setDidSelect:(BOOL)didSelect {
    _didSelect = didSelect;
    
    self.leftLineView.hidden = !didSelect;
    self.bgView.hidden = !didSelect;
    self.titleL.highlighted = didSelect;
    
    self.titleL.font = didSelect ? [UIFont boldSystemFontOfSize:14] : kFont(13);
}



-(void)setCategoryModel:(CU_GoodsCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    
    self.titleL.text = @"title";

}

#pragma mark - seutpUI

-(void)setupUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _leftLineView = [[UIImageView alloc]init];
    _leftLineView.backgroundColor = kRGBA_COLOR(235, 195, 75, 1);;
    _bgView = [[UIImageView alloc]init];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    _titleL = [UILabel labelWithFont:kFont(13) textColor:[UIColor blackColor]];
    _titleL.textAlignment = NSTextAlignmentCenter;
//    _titleL.highlightedTextColor = kMainColor;
    
    [self.contentView addSubview:_bgView];
    [self.contentView addSubview:_titleL];
    [self.contentView addSubview:_leftLineView];
   
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@4);
        make.height.equalTo(@25);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLineView.mas_right).offset(0);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(0);
    }];
}


@end
