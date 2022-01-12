//
//  QXB_BaseViewController.h
//  QiXiuBao_iOS
//
//  Created by zc on 2017/11/13.
//  Copyright © 2017年 qixiubao.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSNavigationView.h"

#import "UIView+EmptyData.h"
//#import "PRO_AccountModel.h"

@interface Base_BaseViewController : UIViewController<EmptyDataViewDataSource,EmptyDataViewDataDelegate>

@property (nonatomic,strong) KSNavigationView *navigationBarView;

@property (nonatomic,copy) NSString *titleText;

//@property (nonatomic,strong) PRO_AccountModel *accountModel;

/** 是否是加载更多 */
@property (nonatomic,assign) BOOL isLoadMore;

/** 页码 */
@property (nonatomic,assign) NSInteger page;

@end
