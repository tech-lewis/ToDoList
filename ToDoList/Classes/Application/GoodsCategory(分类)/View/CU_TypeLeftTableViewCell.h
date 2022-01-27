//
//  PRO_TypeLeftTableViewCell.h
//  QPM_Procurement_iOS
//
//  Created by zc on 2019/3/8.
//  Copyright © 2019 qpm.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CU_GoodsCategoryModel;

@interface CU_TypeLeftTableViewCell : UITableViewCell


@property (nonatomic,assign) BOOL didSelect;

@property (nonatomic,strong) CU_GoodsCategoryModel *categoryModel;

@end

NS_ASSUME_NONNULL_END
