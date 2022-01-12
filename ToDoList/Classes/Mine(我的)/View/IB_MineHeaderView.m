//
//  IB_MineHeaderView.m
//  ImBaby
//
//  Created by zc on 2019/4/16.
//  Copyright © 2019 imbaby.com. All rights reserved.
//

#import "IB_MineHeaderView.h"
#import "UIButton+EnlargeTouchArea.h"
#import "UIView+Extension.h"
#import "Base_Define.h"
@interface IB_MineHeaderView()

@property (weak, nonatomic) IBOutlet UIView *topContainView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomBtnContainView;

@end


@implementation IB_MineHeaderView

+(instancetype)viewWithXib {
    return [[NSBundle mainBundle]loadNibNamed:@"IB_MineHeaderView" owner:nil options:nil].firstObject;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self.avatarImageView setCycle:30];
    self.topContainView.backgroundColor = kMainColor;
    
    for (UIButton *btn in self.bottomBtnContainView.subviews) {
        [btn kc_setImagePosition:KCButtonImagePositionTop margin:8];
    }
    
}

@end
