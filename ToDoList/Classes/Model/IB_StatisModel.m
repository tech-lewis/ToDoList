//
//  TEC_StatisModel.m
//  qpm_technician
//
//  Created by zc on 2018/9/9.
//  Copyright © 2018年 qixiubao.com. All rights reserved.
//

#import "IB_StatisModel.h"

@implementation IB_StatisModel

+(instancetype)statisGroupModelHeaderTitle:(NSString *)headerTitle foogterTitle:(NSString *)footerTitle headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight {
    
    IB_StatisModel *groupModel = [[IB_StatisModel alloc]init];
    groupModel.headerTitle = headerTitle;
    groupModel.footerTitle = footerTitle;
    groupModel.headerHeight = headerHeight;
    groupModel.footerHeight = footerHeight;
    
    return groupModel;
}

+(instancetype)statisItemModelWithTitle:(NSString *)title icon:(NSString *)icon targetVc:(Class)targetVc {
    
    IB_StatisModel *model = [[IB_StatisModel alloc]init];
    model.title = title;
    model.icon = icon;
    model.targetVc = targetVc;
    
    return model;
}

-(NSMutableArray *)group {
    if (_group == nil) {
        _group = [NSMutableArray array];
    }
    return _group;
}


@end
