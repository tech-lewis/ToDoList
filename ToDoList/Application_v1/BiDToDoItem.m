//
//  BiDToDoItem.m
//  ToDoList
//
//  Created by Mark Lewis on 15/1/27.
//  Copyright (c) 2015年 TechLewis. All rights reserved.
//

#import "BiDToDoItem.h"

static NSString * const kItemNote = @"ItemNote";
static NSString * const kItemName = @"ItemName";
static NSString * const kCompleted = @"Completed";
static NSString * const kCreationDate = @"CreationDate";
static NSString * const kPlanDate = @"PlanDate";
static NSString * const kCompletionDate = @"CompletionDate";



@interface BiDToDoItem ()

@property NSDate *completionDate;

@end

@implementation BiDToDoItem

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemNote forKey:kItemNote];
    [aCoder encodeObject:self.itemName forKey:kItemName];
    [aCoder encodeObject:self.creationDate forKey:kCreationDate];
    [aCoder encodeBool:self.completed forKey:kCompleted];
    [aCoder encodeObject:self.planDate forKey:kPlanDate];
    [aCoder encodeObject:self.completionDate forKey:kCompletionDate];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.itemNote = [aDecoder decodeObjectForKey:kItemNote];
        self.itemName = [aDecoder decodeObjectForKey:kItemName];
        self.creationDate = [aDecoder decodeObjectForKey:kCreationDate];
        self.completed = [aDecoder decodeBoolForKey:kCompleted];
        self.planDate = [aDecoder decodeObjectForKey:kPlanDate];
        self.completionDate = [aDecoder decodeObjectForKey:kCompletionDate];
    }
    
    
    return self;
}


#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    BiDToDoItem *copy = [[BiDToDoItem alloc] init];
    
    copy.itemNote = self.itemNote;
    copy.itemName = self.itemName;
    copy.creationDate = self.creationDate;
    copy.planDate = self.planDate;
    copy.completed = self.completed;
    copy.completionDate = self.completionDate;
    
    return copy;
}

#pragma mark - Bug， 有问题的代码。学习日历啊！
- (int)intervalFromDate:(NSDate *)aDate toDate:(NSDate *)newDate
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:aDate toDate:newDate options:0];
    int sec = (int)([d hour]*3600+[d minute]*60+[d second]);
    // NSLog(@"second = %d",[d hour]*3600+[d minute]*60+[d second]);
    
    return sec;
}


- (double)precentOfCreatingDateWithPlainDate
{
    double precent = 0;
    if (self.planDate && self.creationDate)
    {
        double allPlainSec = [self intervalFromDate:self.creationDate toDate:self.planDate];
        int pastSec = [self intervalFromDate:self.creationDate toDate:[NSDate date]];
        precent = pastSec/allPlainSec;
    }
    
    if (precent >= 1 || precent < 0) precent = 1;
    return precent;
}
- (void)markAsCompleted:(BOOL)isComplete
{
    self.completed = isComplete;
    [self setCompletionDate];
}

- (void)setCompletionDate
{
    if (self.completed)
    {
        self.completionDate = [NSDate date];
    }
    else
    {
        self.completionDate = nil;
    }
}
@end
