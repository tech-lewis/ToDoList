//
//  TFY_CacheFileUilt.h
//  ToDoList
//
//  Created by MarkLewis on 2022/1/29.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TFY_CacheFileUilt : NSObject
//获取根式控制器rootViewController，并将rootViewController设置为当前主控制器（防止菜单弹出时，部分被导航栏或标签栏遮盖）
+ (UIViewController *)presentMenuView;
@end
