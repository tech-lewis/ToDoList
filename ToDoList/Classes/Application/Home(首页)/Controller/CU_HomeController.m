//
//  CU_HomeController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_HomeController.h"
#import <AVFoundation/AVFoundation.h>
#import "TYVoiceMemoCell.h"
#import "TYVoiceMemoHeaderView.h"
#import "TYRecorderTool.h"
#import "CU_ChangeLanguageTool.h"
#import "CU_Define.h"
#import "CU_Const.h"
#define TYSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define TYSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString * const cellID = @"CellID";

@interface CU_HomeController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TYVoiceMemoHeaderView *headerView;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) TYVoiceMemoCell *lastSelectedCell;
@property (nonatomic, assign) NSInteger lastSelectedIndexPath_Row;

@end

@implementation CU_HomeController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.gk_navigationBar.barStyle = UIBarStyleBlack;
  self.gk_navTitle = kLocalLanguage(@"Home_Tab") ;
  [self setupUI];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TYNotification_SaveVoiceSuccess:) name:@"TYNotification_SaveVoiceSuccess" object:nil];
  //注册切换语言通知
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
  self.gk_navTitle = kLocalLanguage(@"Home_Tab") ;
}


#pragma mark - 通知方法
- (void)TYNotification_SaveVoiceSuccess:(NSNotification *)notif {
    [self.tableView reloadData];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *nameArra = self.headerView.voiceNameMutArray;
    NSLog(@"%@",nameArra);
    return nameArra.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYVoiceMemoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.memo = self.headerView.memoInstanceMutArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clipsToBounds = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isOpen ? 100 : 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 300;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    TYMemo *memo = self.headerView.memoInstanceMutArray[indexPath.row];
//    // 播放
//    [[TYRecorderTool shareInstance] playbackMemo:memo];
    
    self.isOpen = !self.isOpen;
    self.lastSelectedIndexPath_Row = indexPath.row;
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - Lazy Load
- (UITableView *)tableView {
  if (nil == _tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TYSCREEN_WIDTH, TYSCREEN_HEIGHT-49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.delegate = self;
    [_tableView registerClass:[TYVoiceMemoCell class] forCellReuseIdentifier:cellID];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
  }
  return _tableView;
}

- (TYVoiceMemoHeaderView *)headerView {
    if (nil == _headerView) {
        _headerView = [[TYVoiceMemoHeaderView alloc] init];
    }
    return _headerView;
}

@end
