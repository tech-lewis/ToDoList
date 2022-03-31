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
#import "VoiceRecognizeResultViewController.h"
#define TYSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define TYSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString * const cellID = @"recordCell";

@interface VoiceRecordViewController ()<UITableViewDataSource, UIAlertViewDelegate, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) TYVoiceMemoHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *voiceUrlMutArray;
@property (nonatomic, strong) NSMutableArray *voiceNameMutArray;
@property (nonatomic, strong) NSMutableArray *memoInstanceMutArray;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) TYVoiceMemoCell *lastSelectedCell;
@property (nonatomic, assign) NSInteger lastSelectedIndexPath_Row;
@property (nonatomic, strong) UILongPressGestureRecognizer *lpGesture;
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
  // 添加下拉刷新
  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self action:@selector(pulldownTableViewHandle) forControlEvents:UIControlEventValueChanged];
  [self.tableView addSubview:self.refreshControl];
  
  // add long press gesture
  self.lpGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedCell:)];
  [self.tableView addGestureRecognizer:self.lpGesture];
}

//切换语言通知处理
- (void)changeLanguage:(NSNotification *) notification{
  self.navigationItem.title = kLocalLanguage(@"Home_Tab") ;
}

- (void)pulldownTableViewHandle
{
  self.memoInstanceMutArray = nil;
  [self.tableView reloadData];
  double delayInSeconds = 0.35;
     dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
     dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
       [self.refreshControl endRefreshing];
     });
}

#pragma mark - 通知方法
- (void)TYNotification_SaveVoiceSuccess:(NSNotification *)notif {
    [self.tableView reloadData];
}
- (void)startRecording
{
  UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Start Talking" message:@"Recording..." delegate:self cancelButtonTitle:@"Finish" otherButtonTitles:nil, nil];
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
    for (NSString *filePath in [[NSFileManager defaultManager] enumeratorAtPath:[self documentsPath]])
    {
      if ([filePath.pathExtension isEqualToString:@"wav"])
      {
        NSURL *fileURL = [NSURL fileURLWithPath:[[self documentsPath] stringByAppendingPathComponent:filePath]];
        TYMemo *meno = [TYMemo memoWithTitle:filePath url:fileURL];
        [_memoInstanceMutArray addObject:meno];
      }
    }
  }
  return _memoInstanceMutArray;
}

- (NSString *)documentsPath
{
    // 获取应用程序沙盒的documents路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsPath = paths[0];
    // 合成指定plist文件的全路径
    // NSString *filename=[plistPath1 stringByAppendingPathComponent:@"Music"];
    
    return documentsPath;
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // NSMutableArray *nameArra = self.voiceNameMutArray;
    // NSLog(@"%@",nameArra);
    return self.memoInstanceMutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYVoiceMemoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.memo = self.memoInstanceMutArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clipsToBounds = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  TYMemo *memo = self.memoInstanceMutArray[indexPath.row];
  // 播放
  [[TYRecorderTool shareInstance] playbackMemo:memo];
  self.isOpen = !self.isOpen;
  self.lastSelectedIndexPath_Row = indexPath.row;
  
  [tableView beginUpdates];
  [tableView endUpdates];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)longPressedCell:(UILongPressGestureRecognizer *)sender
{
  // 获得长按的那个Cell
  NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];
  if(indexPath == nil) return;
  // UITableViewCell *selectedCell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
  // CGPoint point = [sender locationInView:self.navigationController.view];
  
  
  // 手势处理代码, 长按打开
  if (sender.state == UIGestureRecognizerStateBegan)
  {
    if ([UIDevice currentDevice].systemVersion.doubleValue <= 10.0)
    {
      /// 使用 8.0之前的
      UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"I'm sorry" message:@"Do not support previous iOS 10 device..." delegate:nil cancelButtonTitle:@"Fine" otherButtonTitles:nil, nil];
      [alerView show];
      return;
    }
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Do you want voice to text？" message:@"Recognizing..." preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"Start recognize" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      PJLRecognitionObject *rec = [[PJLRecognitionObject alloc] init];
      TYMemo *memo = self.memoInstanceMutArray[indexPath.row];
      VoiceRecognizeResultViewController *resultController = [[VoiceRecognizeResultViewController alloc] init];
      [rec recognizeLocalAudioFile:memo.url.absoluteString withRecordBlock:^(NSString *recordStr) {
        /// 语音识别成功
        
        resultController.recogText = recordStr;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
          [self.navigationController pushViewController:resultController animated:true];
        });
        
      } whithLocaleIdentifier:nil];
    }]];
    [alertView addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL]];
    [self presentViewController:alertView animated:true completion:NULL];
  }
}
#pragma mark - UI
- (void)setupUI {
  self.isOpen = true;
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
