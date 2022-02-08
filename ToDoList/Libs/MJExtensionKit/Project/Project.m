//
//  Project.m
//  ToDoList
//
//  Created by MarkLwis on 2022/1/27.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "Project.h"
@implementation Project
// 配置UIApplication中window
- (UIWindow *)window
{
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  [self.window makeKeyAndVisible];
  return self.window;
}



// MARK: - 单例
+ (Project *)defaultInstance
{
  static Project *instance = nil;
  if (instance == nil)
  {
      instance = [[Project alloc] init];
  }
  return instance;
}
@end
