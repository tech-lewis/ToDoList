//
//  Project.h
//  ToDoList
//
//  Created by MarkLwis on 2022/1/27.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Project : NSObject
@property (nonatomic, strong) UIWindow *window;
+ (Project *)defaultInstance;



@end
