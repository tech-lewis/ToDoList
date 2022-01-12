//
//  Base_TableView.h
//  QPMCRM
//
//  Created by zc on 2018/9/7.
//  Copyright © 2018年 qpfww.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)(void);

@interface Base_TableView : UITableView

-(void)registSectionHeaderFooterView:(NSArray <NSString *>*)classNameArray;

-(void)registCell:(NSArray <NSString *>*)classNameArray;

-(void)registCellFromNib:(NSString *)className;

/** 是否是在刷新 */
@property (nonatomic,assign) BOOL isRefreshingInNow;

-(void)endRefresh;

@property (nonatomic,copy) RefreshBlock headerRefreshBlock;

@property (nonatomic,copy) RefreshBlock footerRefreshBlock;

@end
