//
//  VoiceRecognizeResultViewController.m
//  ToDoList
//
//  Created by MarkLwis on 2022/1/27.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "VoiceRecognizeResultViewController.h"

@interface VoiceRecognizeResultViewController ()

@end

@implementation VoiceRecognizeResultViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor grayColor];
  
  UITextView *tv = [[UITextView alloc] init];
  [self.view addSubview:tv];
  
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
