//
//  AddNewNoteController.m
//  ToDoList
//
//  Created by MarkLewis on 2022/1/26.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "AddNewNoteController.h"
#import "NoteEditTextField.h"
#import "NoteListModel.h"

@interface AddNewNoteController ()
@property (nonatomic, assign) NSInteger categoryValue; //默认为其他=6
@property (nonatomic, copy) NSString * remindTime;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;
@property (nonatomic, strong) UILabel * detailLabel;
@property (nonatomic, strong) UIButton * categoryBtn;
@property (nonatomic, strong) UIButton * remindTimeBtn;

@property (nonatomic, strong) UITextField * titleTF;
@property (nonatomic, strong) UITextField * subtitleTF;
@property (nonatomic, strong) NoteEditTextField * detailTextarea;
@property (nonatomic, strong) UILabel * categoryText;
@property (nonatomic, strong) UILabel * createTime;
@property (nonatomic, strong) UILabel * remindTimeLabel;
@property (nonatomic, strong) NoteListModel * item;



@end

@implementation AddNewNoteController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self setupUI];
  [self setUINavigationItem];
}

- (instancetype)initWithBlock:(AddNoteFinishBlock)block
{
  self = [super init];
  if (self) {
    self.completeBlock = block;
  }
  return self;
}
#pragma mark - Action
- (void)addNewItem
{
  
}

- (void)dissmisController
{
  [self dismissViewControllerAnimated:true completion:NULL];
}

#pragma mark - UI
- (void)setUINavigationItem
{
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(dissmisController)];
}
- (void)setupUI
{
  
  CGFloat statusHeight =  self.navigationController.navigationBar.frame.size.height;
  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBG"]];
  self.view.backgroundColor = [UIColor grayColor];
  self.navigationItem.title = @"Addition";

  [self.view addSubview:_titleLabel];
  _titleLabel.textColor = [UIColor grayColor];
  _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
  _titleLabel.text = @"文章标题";
  [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo([UIApplication sharedApplication].statusBarFrame.size.height + statusHeight);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];
  
  [self.view addSubview:_titleTF];
  self.titleTF.backgroundColor = [UIColor clearColor];
  [self.titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.titleLabel.mas_bottom);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];
  
  UIView *titleBottomBorder = [[UIView alloc] init];
  titleBottomBorder.backgroundColor = [UIColor darkTextColor];
  [self.titleTF addSubview:titleBottomBorder];
//  [titleBottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.top.equalTo(self.titleTF.mas_bottom);
//    make.width.equalTo(self.titleTF.mas_width);
//    make.centerX.equalTo(self.view);
//    make.height.mas_equalTo(1);
//  }];
  
  [self.view addSubview:_subtitleLabel];
  _subtitleLabel.textColor = [UIColor grayColor];
  _subtitleLabel.font = [UIFont boldSystemFontOfSize:11];
  _subtitleLabel.text = @"文章副标题";
  [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.titleTF.mas_bottom);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];

  [self.view addSubview:_subtitleTF];
  _subtitleTF.backgroundColor = [UIColor clearColor];
  [_subtitleTF mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.subtitleLabel.mas_bottom);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];

  UIView *titleBottomBorder2 = [[UIView alloc] init];
  titleBottomBorder2.backgroundColor = [UIColor grayColor];
  [_subtitleTF addSubview:titleBottomBorder2];
//  [titleBottomBorder2 mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.top.equalTo(self.subtitleTF.mas_bottom);
//    make.width.equalTo(self.subtitleTF.mas_width);
//    make.centerX.equalTo(self.view);
//    make.height.mas_equalTo(1);
//  }];
  
  [self.view addSubview:_detailLabel];
  _detailLabel.textColor = [UIColor grayColor];
  _detailLabel.font = [UIFont boldSystemFontOfSize:11.0];
  _detailLabel.text = @"请输入描述";
  [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.subtitleTF.mas_bottom);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];
  
  [self.view addSubview: _detailTextarea];
  _detailLabel.layer.cornerRadius = 5.0;
  _detailLabel.clipsToBounds = true;
  _detailLabel.layer.masksToBounds = true;
  _detailTextarea.backgroundColor = [UIColor clearColor];
  _detailTextarea.selectFirstMenuIemBlock = ^{
//      let controller = AddNewNoteEditorController()
//      controller.finishEditingBlock = { (text) in
//          self.detailTextarea.text = text
//      }
//      self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
  };
  
  [_detailTextarea mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.detailLabel.mas_bottom);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];
  
  UIView *detailBottomBorder = [[UIView alloc] init];
  detailBottomBorder.backgroundColor = [UIColor grayColor];
  [self.view addSubview:detailBottomBorder];
//  [detailBottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.top.equalTo(self.detailTextarea.mas_bottom);
//    make.width.equalTo(self.detailTextarea.mas_width);
//    make.centerX.equalTo(self.view);
//    make.height.mas_equalTo(1);
//  }];
  
  [self.view addSubview:_createTime];
  _createTime.textColor = [UIColor grayColor];
  _createTime.font = [UIFont boldSystemFontOfSize:11];
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd hh:mm";
  _createTime.text = [NSString stringWithFormat:@"创建时间为: %@", [fmt stringFromDate:[NSDate date]]];
  [_createTime mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.detailTextarea.mas_bottom);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];

  [self.view addSubview:_categoryText];
  _categoryText.textColor = [UIColor grayColor];
  _categoryText.font = [UIFont boldSystemFontOfSize:11];
  _categoryText.text = @"未选择分类(默认=其他)";
  [_categoryText mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.createTime.mas_bottom);
    make.left.equalTo(self.createTime.mas_left);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(119.0);
  }];
  
  [self.view addSubview:_categoryBtn];
  _categoryBtn.tintColor = [UIColor blueColor];
  [_categoryBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  // _categoryBtn.addTarget(self, action: #selector(selectCategoryAction), for: .touchUpInside)
  [_categoryBtn setTitle:@"选择分类" forState:UIControlStateNormal];
  [_categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.createTime.mas_bottom);
    make.right.equalTo(self.view.mas_right);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(100.0);
  }];
  
  [self.view addSubview:_remindTimeBtn];
  _remindTimeBtn.tintColor = [UIColor blueColor];
  [_remindTimeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  // remindTimeBtn.addTarget(self, action: #selector(selectRemindTimeAction), for: .touchUpInside)
  [_remindTimeBtn setTitle:@"选择提醒时间" forState:UIControlStateNormal];
  _remindTimeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
  [_remindTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.categoryBtn.mas_bottom);
    make.right.equalTo(self.categoryBtn.mas_right);
    make.height.equalTo(self.categoryBtn);
    make.width.mas_equalTo(110.0);
  }];
  
  [self.view addSubview:_remindTimeLabel];
  _remindTimeLabel.textColor = [UIColor grayColor];
  _remindTimeLabel.font = [UIFont boldSystemFontOfSize:11.0];
  _remindTimeLabel.text = @"Choose remind time";
  [_remindTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.categoryText.mas_left);
    make.centerY.equalTo(self.remindTimeBtn);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(150.0);
  }];
}
@end
