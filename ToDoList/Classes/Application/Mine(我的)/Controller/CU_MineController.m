//
//  CU_MineController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_MineController.h"
#import "CU_ChangeLanguageTool.h"
#import "CU_Define.h"
#import "CU_Const.h"
@interface CU_MineController ()

@property (nonatomic,strong) UILabel *testLab ;
@property (nonatomic,strong) UIButton *testBtn ;

@end

@implementation CU_MineController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = kLocalLanguage(@"Mine_Tab") ;
  // NSLog(@"%@", [CU_ChangeLanguageTool userLanguage]);
  //UI布局
  [self configUI] ;
  //注册切换语言通知
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
  
  self.navigationItem.title = kLocalLanguage(@"Mine_Tab") ;
  [self.testBtn setTitle:kLocalLanguage(@"Mine_button") forState:UIControlStateNormal];
  self.testLab.text = kLocalLanguage(@"Mine_text");
}

#pragma mark - UI布局
-(void) configUI{
  UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
  [self.view addSubview:iconView];
  [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.width.mas_equalTo(50);
    make.height.mas_equalTo(50);
  }];
  
  [self.view addSubview:self.testLab];
  [self.testLab mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.view);
    make.top.equalTo(iconView.mas_bottom).offset(kAdaptedWidth(10)) ;
  }] ;
  [self.view addSubview:self.testBtn];
  [self.testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.view);
    make.top.equalTo(self.testLab.mas_bottom).offset(kAdaptedWidth(100)) ;
  }] ;

  self.testLab.text = kLocalLanguage(@"Mine_text") ;
  [self.testBtn setTitle:kLocalLanguage(@"Mine_button") forState:UIControlStateNormal];
}

#pragma mark - 点击事件
-(void) testBtnClick:(id) sender{
    //修改语言
    NSString *language = [CU_ChangeLanguageTool userLanguage];
    if ([language isEqualToString:@"en"]) {
        [CU_ChangeLanguageTool setUserlanguage:@"zh-Hans"];
    }else{
        [CU_ChangeLanguageTool setUserlanguage:@"en"];
    }
    //发送修改语言通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeLanguageNotice object:self];
}

#pragma mark - Getter
-(UILabel *)testLab{
    if (!_testLab) {
        _testLab = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"hello world";//内容显示
            label.textColor = [UIColor grayColor];//设置字体颜色
            label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;///设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _testLab ;
}

-(UIButton *)testBtn{
    if (!_testBtn) {
        _testBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"正常状态文字" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal] ;
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]] ;
            [btn addTarget:self action:@selector(testBtnClick:) forControlEvents:UIControlEventTouchUpInside] ;
            btn ;
        }) ;
    }
    return _testBtn ;
}

@end
