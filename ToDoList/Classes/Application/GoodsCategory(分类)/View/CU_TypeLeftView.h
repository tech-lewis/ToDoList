//
//  PRO_TypeLeftView.h
//  QPM_Procurement_iOS
//
//  Created by zc on 2019/3/8.
//  Copyright © 2019 qpm.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CU_GoodsCategoryModel;

NS_ASSUME_NONNULL_BEGIN

@protocol AB_TypeLeftViewDelegate <NSObject>

-(void)AB_TypeLeftViewDidClickLeftItem:(id)obj;


@end

@interface CU_TypeLeftView : UIView

@property (nonatomic,weak) id <AB_TypeLeftViewDelegate> delegate;


@property (nonatomic,strong) NSArray *list;

/** 选中索引 */
@property (nonatomic,assign) NSInteger selectIndexSection;

@end

NS_ASSUME_NONNULL_END
