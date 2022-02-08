//
//  BiDToDoItem.h
//  ToDoList
//
//  Created by Mark Lewis on 15/1/27.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BiDToDoItem : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSString *itemNote; // 备注
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSDate *planDate; // 计划完成时间

@property BOOL completed;


- (void)markAsCompleted:(BOOL)isComplete;
- (double)precentOfCreatingDateWithPlainDate;

@end
