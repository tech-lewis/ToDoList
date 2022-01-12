//
//  TEC_StatisModel.h
//  qpm_technician
//
//  Created by zc on 2018/9/9.
//  Copyright © 2018年 qixiubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IB_StatisModel : NSObject

+(instancetype)statisGroupModelHeaderTitle:(NSString *)headerTitle foogterTitle:(NSString *)footerTitle headerHeight:(CGFloat)headerHeight footerHeight:(CGFloat)footerHeight;

+(instancetype)statisItemModelWithTitle:(NSString *)title icon:(NSString *)icon targetVc:(Class)targetVc;

@property (nonatomic,strong) NSMutableArray *group;

@property (nonatomic,copy) NSString *reuseID;

@property (nonatomic,assign) BOOL cellIsFromXib;

@property (nonatomic,copy) NSString *headerTitle;

@property (nonatomic,copy) NSString *footerTitle;

@property (nonatomic,copy) NSString *headerViewReuseId;

@property (nonatomic,copy) NSString *footerViewReuseID;

@property (nonatomic,assign) CGFloat headerHeight;

@property (nonatomic,assign) CGFloat footerHeight;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,strong) Class targetVc;

@property (nonatomic,assign) CGFloat rowHeight;

@property (nonatomic,assign) NSInteger itemCount;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *placeHolder;

@property (nonatomic,assign) CGSize itemSize;

@property (nonatomic,assign) UIEdgeInsets insets;

@property (nonatomic,assign) CGFloat minLineSpace;

@property (nonatomic,assign) CGFloat minInterSpace;


@end
