//
//  VoiceRecognizeResultViewController.m
//  ToDoList
//
//  Created by MarkLwis on 2022/1/27.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "VoiceRecognizeResultViewController.h"
#import "VoiceRecognizeTextView.h"
@interface VoiceRecognizeResultViewController ()
@property (nonatomic, strong) VoiceRecognizeTextView * detailTextarea;
@end

@implementation VoiceRecognizeResultViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor grayColor];
  self.navigationItem.title = @"✅识别成功";
  self.detailTextarea = [[VoiceRecognizeTextView alloc] init];
  self.detailTextarea.text = self.recogText;
  [self.view addSubview:self.detailTextarea];
  [self.detailTextarea mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
  
}

- (void)setRecogText:(NSString *)recogText
{
  self.detailTextarea.text = recogText;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
