//
//  Base_TableView.m
//  QPMCRM
//
//  Created by zc on 2018/9/7.
//  Copyright © 2018年 qpfww.com. All rights reserved.
//

#import "Base_TableView.h"

@implementation Base_TableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
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

-(BOOL)isRefreshingInNow {
    
    if ([self.mj_header isRefreshing] || [self.mj_footer isRefreshing]) {
        return YES;
    }
    return NO;;
}

-(void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

-(void)setHeaderRefreshBlock:(RefreshBlock)headerRefreshBlock {
    
    _headerRefreshBlock = headerRefreshBlock;
    
    WS(ws)
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        !ws.headerRefreshBlock ? : ws.headerRefreshBlock();
    }];
}

-(void)setFooterRefreshBlock:(RefreshBlock)footerRefreshBlock {
    
    _footerRefreshBlock = footerRefreshBlock;
    
    WS(ws)
    
    ws.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        !ws.footerRefreshBlock ? : ws.footerRefreshBlock();
    }];
}

@end
