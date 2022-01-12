//
//  VM_MineViewController.m
//  VehicleMaster_iOS
//
//  Created by zc on 2018/12/4.
//  Copyright © 2018 qipeimao.com. All rights reserved.
//

#import "IB_MineViewController.h"
#import "IB_MineHeaderView.h"
#import "IB_MineFooterView.h"
#import "UIView+Extension.h"
#import "Base_TableView.h"
#import "Base_Define.h"
@interface IB_MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) Base_TableView *tableView;

@property (nonatomic,strong) IB_MineHeaderView *headeView;

@property (nonatomic,strong) IB_MineFooterView *footerView;

@end

@implementation IB_MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleText = @"个人中心";
    
    [self setupUI];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.headeView.size = CGSizeMake(kScreenWidth, 265);
    self.tableView.tableHeaderView   = self.headeView;
    
    self.footerView.size = CGSizeMake(kScreenWidth,kScreenWidth * 0.6);
    self.tableView.tableFooterView = self.footerView;
}

#pragma mark - UITableView_DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    
    return cell;
}


#pragma mark - setupUI

-(void)setupUI {
    
    _tableView = [[Base_TableView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource  = self;
    _tableView.backgroundColor = kGloableBackgroundColor;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationBarView.mas_bottom);
    }];
}

-(IB_MineHeaderView *)headeView {
    if (_headeView == nil) {
        _headeView = [IB_MineHeaderView viewWithXib];
    }
    return _headeView;
}

-(IB_MineFooterView *)footerView {
    if (_footerView == nil) {
        _footerView = [[IB_MineFooterView alloc]init];
    }
    return _footerView;
}



@end
