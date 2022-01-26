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
- (void)saveAddtionItem
{
  if (!self.completeBlock) return;
  if (!self.titleTF.text) return;
  if (!self.subtitleTF.text) return;
  if (!self.detailTextarea.text) return;
  if (!self.remindTime) {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"未选择完成时间" message:@"点击灰色按钮选择时间" preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      //
    }]];
    [self presentViewController:alertView animated:true completion:NULL];
  }
  
  if (self.remindTime.length <= 0) {
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"未选择完成时间" message:@"点击灰色按钮选择时间" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          //
        }]];
        [self presentViewController:alertView animated:true completion:NULL];
    }
  }
  self.item = [[NoteListModel alloc] initWithTitle:self.titleTF.text subtitle:self.subtitleTF.text detail:self.detailTextarea.text category:@(self.categoryValue) remind:self.remindTime];
  if (self.completeBlock) {
    self.completeBlock(_item);
    [self dismissViewControllerAnimated:true completion:NULL];
  }
}

- (void)dissmisController
{
  [self dismissViewControllerAnimated:true completion:NULL];
}
#pragma mark - Action
- (void)selectCategoryAction
{
  if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0) {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"请选择项目类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertView addAction:[UIAlertAction actionWithTitle:@"服饰" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      /// 代表0
      self.categoryValue = 0;
      self.categoryText.text = @"服饰";
    }]];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"食物" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      /// 代表1
      self.categoryValue = 1;
      self.categoryText.text = @"食物";
    }]];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"住宿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      /// 代表2
      self.categoryValue = 2;
      self.categoryText.text = @"住宿";
    }]];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"交通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      /// 代表3
      self.categoryValue = 3;
      self.categoryText.text = @"交通";
    }]];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"通讯" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      /// 代表0
      self.categoryValue = 4;
      self.categoryText.text = @"通讯";
    }]];
    [alertView addAction:[UIAlertAction actionWithTitle:@"数码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      /// 代表5
      self.categoryValue = 5;
      self.categoryText.text = @"数码";
    }]];
    [alertView addAction:[UIAlertAction actionWithTitle:@"通讯" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      /// 代表6
      self.categoryValue = 6;
      self.categoryText.text = @"通讯";
    }]];
    [alertView addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      /// 代表7
      self.categoryValue = 7;
      self.categoryText.text = @"其他";
    }]];
    [self presentViewController:alertView animated:true completion:NULL];
  }
}

- (void)selectRemindTimeAction
{
  // 选择分类
  UIDatePicker *datePicker = [[UIDatePicker alloc] init];
  // 将日期选择器区域设置为中文，则选择器日期显示为中文
  // datePicker.locale = Locale(identifier: "zh_CN")
  // 设置样式，当前设为同时显示日期和时间
  datePicker.calendar = [NSCalendar currentCalendar];
  datePicker.datePickerMode = UIDatePickerModeDateAndTime;
  
  // 设置默认时间
  datePicker.date = [NSDate date];
  // 响应事件（只要滚轮变化就会触发）
  
  if ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0)
  {
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertView.view.layer.masksToBounds = true;
    [alertView.view addSubview:datePicker];
    
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      //print("date select: \(datePicker.date.description)")
      NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
      fmt.dateFormat = @"yyyy-MM-dd hh:mm:ss";
      
      self.remindTimeLabel.text = [fmt stringFromDate:datePicker.date];
      self.remindTime = self.remindTimeLabel.text;
    }]];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:NULL]];
    [self presentViewController:alertView animated:true completion:NULL];
  } else {
      // Fallback on earlier versions
      // iOS 7系统兼容
  }
}

#pragma mark - UI
- (void)setUINavigationItem
{
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(dissmisController)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAddtionItem)];
}
- (void)setupUI
{
  CGFloat statusHeight =  self.navigationController.navigationBar.frame.size.height;
  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homeBG"]];
  self.navigationItem.title = @"Addition";
  
  self.titleLabel = [[UILabel alloc] init];
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
  
  self.titleTF = [[UITextField alloc] init];
  [self.view addSubview:_titleTF];
  self.titleTF.backgroundColor = [UIColor clearColor];
  [self.titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.titleLabel.mas_bottom);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];
  
  UIView *titleBottomBorder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_line"]];
  [self.titleTF addSubview:titleBottomBorder];
  [titleBottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.titleTF.mas_top).mas_offset(20);
    make.width.equalTo(self.titleTF.mas_width);
    make.centerX.equalTo(self.view);
    make.height.equalTo(self.titleTF);
  }];
  
  self.subtitleLabel = [[UILabel alloc] init];
  [self.view addSubview:_subtitleLabel];
  _subtitleLabel.textColor = [UIColor grayColor];
  _subtitleLabel.font = [UIFont boldSystemFontOfSize:11];
  _subtitleLabel.text = @"文章副标题";
  [_subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.titleTF.mas_bottom).mas_offset(8);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];

  self.subtitleTF = [[UITextField alloc] init];
  [self.view addSubview:_subtitleTF];
  _subtitleTF.backgroundColor = [UIColor clearColor];
  [_subtitleTF mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.subtitleLabel.mas_bottom);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];

  UIView *titleBottomBorder2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_line"]];
  
  [_subtitleTF addSubview:titleBottomBorder2];
  [titleBottomBorder2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.subtitleTF.mas_top).mas_offset(20);;
    make.width.equalTo(self.subtitleTF.mas_width);
    make.centerX.equalTo(self.view);
    make.height.equalTo(self.subtitleTF);
  }];
  
  self.detailLabel = [[UILabel alloc] init];
  [self.view addSubview:_detailLabel];
  _detailLabel.textColor = [UIColor grayColor];
  _detailLabel.font = [UIFont boldSystemFontOfSize:11.0];
  _detailLabel.text = @"请输入描述";
  [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.subtitleTF.mas_bottom).mas_offset(8);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];
  
  self.detailTextarea = [[NoteEditTextField alloc] init];
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
  
  UIView *detailBottomBorder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_line"]];
  [self.view addSubview:detailBottomBorder];
  [detailBottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.detailTextarea.mas_top).mas_offset(20);
    make.width.equalTo(self.detailTextarea.mas_width);
    make.centerX.equalTo(self.view);
    make.height.equalTo(self.detailTextarea.mas_height);
  }];
  
  self.createTime = [[UILabel alloc] init];;
  [self.view addSubview:_createTime];
  _createTime.textColor = [UIColor grayColor];
  _createTime.font = [UIFont boldSystemFontOfSize:11];
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd hh:mm";
  _createTime.text = [NSString stringWithFormat:@"创建时间为: %@", [fmt stringFromDate:[NSDate date]]];
  [_createTime mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.detailTextarea.mas_bottom).mas_offset(8);
    make.centerX.equalTo(self.view);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(300.0);
  }];

  self.categoryText = [[UILabel alloc] init];
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
  
  self.categoryBtn  = [[UIButton alloc] init];
  [self.view addSubview:_categoryBtn];
  _categoryBtn.tintColor = [UIColor blueColor];
  [_categoryBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [_categoryBtn addTarget:self action:@selector(selectCategoryAction) forControlEvents:UIControlEventTouchUpInside];
  [_categoryBtn setTitle:@"选择分类" forState:UIControlStateNormal];
  [_categoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.createTime.mas_bottom);
    make.right.equalTo(self.view.mas_right);
    make.height.mas_equalTo(30.0);
    make.width.mas_equalTo(100.0);
  }];
  
  self.remindTimeBtn = [[UIButton alloc] init];
  [self.view addSubview:_remindTimeBtn];
  _remindTimeBtn.tintColor = [UIColor blueColor];
  [_remindTimeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
  [_remindTimeBtn addTarget:self action:@selector(selectRemindTimeAction) forControlEvents:UIControlEventTouchUpInside];
  [_remindTimeBtn setTitle:@"选择提醒时间" forState:UIControlStateNormal];
  _remindTimeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13.0];
  [_remindTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.categoryBtn.mas_bottom);
    make.right.equalTo(self.categoryBtn.mas_right);
    make.height.equalTo(self.categoryBtn);
    make.width.mas_equalTo(110.0);
  }];
  
  self.remindTimeLabel = [[UILabel alloc] init];
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
