//
//  QXB_BaseViewController.m
//  QiXiuBao_iOS
//
//  Created by zc on 2017/11/13.
//  Copyright © 2017年 qixiubao.com. All rights reserved.
//

#import "Base_BaseViewController.h"
#import "UIView+Extension.h"
#import "Base_Define.h"
@interface Base_BaseViewController()


@end


@implementation Base_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kGloableBackgroundColor;
    
    [self setupTopUI];
    
    self.view.emptyView.dataSource = self;
    self.view.emptyView.delegate = self;
    
}


-(void)dealloc
{
    
    NSLog(@"释放：%@",NSStringFromClass([self class]));
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.navigationBarView.frame = CGRectMake(0, 0, kScreenWidth, kNavgationBarH);
}



-(CGRect)emptyDataViewSettingFrame:(CGRect)rect {
    return CGRectMake(0, kNavgationBarH, kScreenWidth, kScreenHeight - kNavgationBarH);
}

-(NSString *)emptyDataViewSettingImageView:(NSString *)imageName {
    return @"ic_nodata";
}

-(NSString *)emptyDataViewSettingTitle:(NSString *)title {
    return @"暂无数据";
}

#pragma mark - setupUI

-(void)setupTopUI
{
    
    [self.view addSubview:self.navigationBarView];
    
}

-(void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    self.navigationBarView.title = titleText;
}

#pragma mark - lazy

-(KSNavigationView *)navigationBarView
{
    if (_navigationBarView == nil) {
        _navigationBarView = [[KSNavigationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavgationBarH)];
        _navigationBarView.backgroundView.backgroundColor = kMainColor;
        _navigationBarView.titleLabel.textColor = [UIColor whiteColor];
       
    }
    
    return _navigationBarView;
}


//-(PRO_AccountModel *)accountModel {
//    if (_accountModel == nil) {
//        _accountModel = [PRO_AccountModel currentAccountModel];
//    }
//    return _accountModel;
//}
//


@end
