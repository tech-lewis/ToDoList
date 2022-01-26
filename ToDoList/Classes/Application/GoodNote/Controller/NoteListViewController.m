//
//  NoteListViewController.m
//  ToDoList
//
//  Created by MarkLewis on 2022/1/26.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "NoteListViewController.h"
#import "AddNewNoteController.h"
#import "NoteCacheTools.h"
#import "CU_NavitationViewController.h"
#import "NoteListModel.h"
@interface NoteListViewController ()
@property (nonatomic, strong) NSMutableArray *listDatas;
@end

@implementation NoteListViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navigationItem.title = @"SQLite Note";
  self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickAddHandler)];
}
#pragma mark - ib Action
- (void)clickAddHandler
{
  AddNewNoteController *controller = [[AddNewNoteController alloc] initWithBlock:^(NoteListModel *data) {
    // 完成编辑 刷新列表
    self.listDatas = nil;
    [self.tableView reloadData];
  }];
  CU_NavitationViewController *nav = [[CU_NavitationViewController alloc] initWithRootViewController:controller];
  
  [self presentViewController:nav animated:true completion:NULL];
  
}

#pragma mark - instance var
- (NSMutableArray *)listDatas
{
  if (_listDatas == nil)
  {
    _listDatas = [NSMutableArray array];
    for(NoteListModel *item in [NoteCacheTools findAllNotes]) {
      [_listDatas addObject:item];
    }
  }
  return _listDatas;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.listDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = @"NoteListCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
  }
  
  // set data
  NoteListModel *data = self.listDatas[indexPath.row];
  cell.textLabel.text = data.title;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"创建时间: %@", data.createTime];
  return cell;
}
@end
