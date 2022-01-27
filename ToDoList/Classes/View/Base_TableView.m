//
//  Base_TableView.m
//  QPMCRM
//
//  Created by zc on 2018/9/7.
//  Copyright © 2018年 qpfww.com. All rights reserved.
//

#import "Base_TableView.h"
#import "CU_ChangeLanguageTool.h"
#import "CU_Define.h"

@implementation Base_TableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.rowHeight = 44;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = kRGBA_COLOR(240, 240, 240, 1);
        self.page = 1;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            self.estimatedRowHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
        }
        
//        self.tableFooterView = [UIView new];
    }
    return self;
}

-(void)registCell:(NSArray <NSString *>*)classNameArray {
    for (NSString *className in classNameArray) {
        Class cell = NSClassFromString(className);
        if (cell) {
            [self registerClass:[cell class] forCellReuseIdentifier:className];
        }
    }
}

-(void)registCellFromNib:(NSString *)className {
    
    [self registerNib:[UINib nibWithNibName:className bundle:nil] forCellReuseIdentifier:className];
}

-(void)registSectionHeaderFooterView:(NSArray <NSString *> *)classNameArray {
    
    for (NSString *className in classNameArray) {
        Class view = NSClassFromString(className);
        if (view) {
            [self registerClass:[view class] forHeaderFooterViewReuseIdentifier:className];
        }
    }
    
}


-(void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

-(void)setHeaderRefreshBlock:(RefreshBlock)headerRefreshBlock {
    
    _headerRefreshBlock = headerRefreshBlock;
    
    __weak typeof(self) ws = self;
    ws.page = 1;
    MJRefreshNormalHeader *header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        ws.page = 1;
        ws.isLoadMore = NO;
        !ws.headerRefreshBlock ? : ws.headerRefreshBlock();
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

-(void)setFooterRefreshBlock:(RefreshBlock)footerRefreshBlock {
    
    _footerRefreshBlock = footerRefreshBlock;
    
   __weak typeof(self) ws = self;
    ws.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        ws.page += 1;
        ws.isLoadMore = YES;
        !ws.footerRefreshBlock ? : ws.footerRefreshBlock();
    }];
}

-(BOOL)isRefreshingInNow {
    
    if ([self.mj_header isRefreshing] || [self.mj_footer isRefreshing]) {
        return YES;
    }
    return NO;;
}


@end
