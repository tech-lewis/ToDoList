//
//  CU_ShoppingCartController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_ShoppingCartController.h"
#import "CU_ShoppingCartCell.h"
#import "CU_ShoppingCartSectionHeaderView.h"

@interface CU_ShoppingCartController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView ;

@end

@implementation CU_ShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = kLocalLanguage(@"Cart_Tab") ;
    //UI布局
    [self configUI] ;
    //注册切换语言通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
    self.gk_navTitle = kLocalLanguage(@"Cart_Tab") ;
}

#pragma mark - UI布局
-(void) configUI{
    [self.view addSubview:self.tableView] ;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationAndStatusHeight);
        make.left.right.bottom.equalTo(self.view) ;
    }] ;
}

#pragma mark - TableView协议，数据源
// 多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3 ;
}

// 每一组有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5 ;
}

// 每一行显示什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CU_ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CU_ShoppingCartCell class])];
    
    return cell;
}

//修改Section背景色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.contentView.backgroundColor = [UIColor whiteColor];
}

// 每一组头部行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kAdaptedWidth(40) ;
}

// 每一组尾部行高
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10 ;
}



// 设置每一组头部视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *viewIdentfier = @"headView";
    CU_ShoppingCartSectionHeaderView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!sectionHeadView){
        sectionHeadView = [[CU_ShoppingCartSectionHeaderView alloc] initWithReuseIdentifier:viewIdentfier];
    }
    return sectionHeadView;
}

// 选中一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES] ;
}


#pragma mark - Getter
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
            tableView.dataSource = self;
            tableView.delegate = self;
            //设置分割线样式
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //隐藏底部多余分割线
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            //隐藏头部多余间距
            tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
            //iOS11默认开启Self-Sizing，需关闭才能设置Header,Footer高度
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            //selfSizing
            tableView.estimatedRowHeight = 44.0 ;
            tableView.rowHeight = UITableViewAutomaticDimension ;
            //注册
            [tableView registerClass:[CU_ShoppingCartCell class]forCellReuseIdentifier:NSStringFromClass([CU_ShoppingCartCell class])];
            tableView ;
        }) ;
    }
    
    return _tableView;
}

@end
