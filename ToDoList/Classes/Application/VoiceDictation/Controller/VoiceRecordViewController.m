//
//  VoiceRecordViewController.m
//  ToDoList
//
//  Created by MarkLwis on 2022/1/27.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "VoiceRecordViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "TYVoiceMemoCell.h"
#import "TYVoiceMemoHeaderView.h"
#import "TYRecorderTool.h"
#import "CU_ChangeLanguageTool.h"
#import "CU_Define.h"
#import "CU_Const.h"
#import "TYMemo.h"
#define TYSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define TYSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString * const cellID = @"recordCell";

@interface VoiceRecordViewController ()<UITableViewDataSource, UIAlertViewDelegate, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TYVoiceMemoHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *voiceUrlMutArray;
@property (nonatomic, strong) NSMutableArray *voiceNameMutArray;
@property (nonatomic, strong) NSMutableArray *memoInstanceMutArray;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) TYVoiceMemoCell *lastSelectedCell;
@property (nonatomic, assign) NSInteger lastSelectedIndexPath_Row;

@end

@implementation VoiceRecordViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // self.gk_navigationBar.barStyle = UIBarStyleBlack;
  self.navigationItem.title = kLocalLanguage(@"Home_Tab") ;
  [self setupUI];
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(startRecording)];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TYNotification_SaveVoiceSuccess:) name:@"TYNotification_SaveVoiceSuccess" object:nil];
  //注册切换语言通知
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
  self.navigationItem.title = kLocalLanguage(@"Home_Tab") ;
}


#pragma mark - 通知方法
- (void)TYNotification_SaveVoiceSuccess:(NSNotification *)notif {
    [self.tableView reloadData];
}
- (void)startRecording
{
  UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Start Speaking" message:@"Recording..." delegate:self cancelButtonTitle:@"Finish" otherButtonTitles:nil, nil];
  [alerView show];
  [[TYRecorderTool shareInstance] record];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if(alertView.cancelButtonIndex == buttonIndex)
  {
    //停止录音
    [[TYRecorderTool shareInstance] stopWithCompletionHandler:^(BOOL isSuccess) {
      if (isSuccess) {
        [[TYRecorderTool shareInstance] saveRecordingWithName:@"Audio" completionHandler:^(BOOL isSuccess, TYMemo *memo) {
          if (isSuccess) {
            NSString *voiceName = memo.name;
              
            [self.memoInstanceMutArray addObject:memo];
            [self.voiceNameMutArray addObject:voiceName];
            [self.voiceUrlMutArray addObject:memo.url];
              
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TYNotification_SaveVoiceSuccess" object:nil];
          }
        }];
      }
    }];
  }
}

- (NSMutableArray *)voiceNameMutArray {
    if (nil == _voiceNameMutArray) {
        _voiceNameMutArray = [NSMutableArray array];
    }
    return _voiceNameMutArray;
}

- (NSMutableArray *)voiceUrlMutArray {
    if (nil == _voiceUrlMutArray) {
        _voiceUrlMutArray = [NSMutableArray array];
    }
    return _voiceUrlMutArray;
}

- (NSMutableArray *)memoInstanceMutArray {
    if (nil == _memoInstanceMutArray) {
        _memoInstanceMutArray = [NSMutableArray array];
    }
    return _memoInstanceMutArray;
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
    _tableView.backgroundColor = [UIColor whiteColor];
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
