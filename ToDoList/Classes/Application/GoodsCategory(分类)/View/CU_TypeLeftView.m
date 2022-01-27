//
//  PRO_TypeLeftView.m
//  QPM_Procurement_iOS
//
//  Created by zc on 2019/3/8.
//  Copyright © 2019 qpm.com. All rights reserved.
//

#import "CU_TypeLeftView.h"
#import "CU_TypeLeftTableViewCell.h"
#import "CU_GoodsCategoryModel.h"
#import "Base_TableView.h"
@interface CU_TypeLeftView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) Base_TableView *tableView;

@property (nonatomic,assign) NSInteger index;

@end


@implementation CU_TypeLeftView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setList:(NSArray *)list {
    _list = list;
    [self.tableView reloadData];
}
-(void)setSelectIndexSection:(NSInteger)selectIndexSection {
    _selectIndexSection = selectIndexSection;
    
    self.index  = selectIndexSection;
    [self.tableView reloadData];
}

#pragma mark - UITableView_DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.list.count;
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CU_TypeLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CU_TypeLeftTableViewCell"];
    
//    cell.didSelect = indexPath.row == self.index ? YES : NO;
//    cell.categoryModel = self.list[indexPath.row];
  
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.index = indexPath.row;
    [self.tableView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(AB_TypeLeftViewDidClickLeftItem:)]) {
        [self.delegate AB_TypeLeftViewDidClickLeftItem:self.list[indexPath.row]];
    }
}

#pragma mark - seutpUI

-(void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[Base_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [_tableView registCell:@[@"CU_TypeLeftTableViewCell"]];
    
    [self addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self);
        make.right.equalTo(self.mas_right);
    }];
}

@end
