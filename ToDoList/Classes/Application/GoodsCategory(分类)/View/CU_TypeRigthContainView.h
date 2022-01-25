//
//  PRO_TypeRightView.h
//  QPM_Procurement_iOS
//
//  Created by zc on 2019/3/8.
//  Copyright © 2019 qpm.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CU_GoodsCategoryModel;

NS_ASSUME_NONNULL_BEGIN

@protocol AB_TypeRightContainCellDelegate <NSObject>


-(void)AB_TypeRightContainCellClickItem:(CU_GoodsCategoryModel *)item section:(NSInteger)sectin;

@end


@interface CU_TypeRigthContainView : UIView

@property (nonatomic,weak) id <AB_TypeRightContainCellDelegate> delegate;

@property (nonatomic,assign) NSInteger section;

@property (nonatomic,strong) NSArray *cchlist;

/** 选中索引 */
@property (nonatomic,assign) NSInteger selectIndexSection;


@end

NS_ASSUME_NONNULL_END
