//
//  CU_LoginController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_LoginController.h"
// #import "RCTRootView.h"
#import "BiDAppDelegate.h"
@interface CU_LoginController ()

@end

@implementation CU_LoginController

- (void)loadView
{
  [super loadView];
//  NSURL * jsCodeLocation = [NSURL URLWithString:@"http://192.168.8.234:8081/index.ios.bundle?platform=ios&dev=true"];
//  NSDictionary *launchOptions = [(BiDAppDelegate *)[UIApplication sharedApplication].delegate launchOptions];
//  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                      moduleName:@"AImageDemo"
//                                               initialProperties:nil
//                                                   launchOptions:launchOptions];
  // self.view = rootView;
}

- (void)viewDidLoad {
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(retry)];
}

- (void)retry
{
  if (self.block) self.block();
  // [self.navigationController popViewControllerAnimated:true];
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
