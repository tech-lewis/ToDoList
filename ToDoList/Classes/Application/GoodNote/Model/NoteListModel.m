//
//  NoteListModel.m
//  ToDoList
//
//  Created by MarkLewis on 2021/12/26.
//  Copyright © 2021 mark. All rights reserved.
//

#import "NoteListModel.h"

@implementation NoteListModel

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle detail:(NSString *)detail category:(NSNumber *)category remind:(NSString *)remindTime
{
    self = [self init];
    if (self) {
        self.title = title;
        self.subtitle = subtitle;
        self.detail = detail;
        self.category = category;
        self.remindTime = remindTime;
    }
    
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
        self.subtitle = @"subtitle";
        self.detail = @"";
        self.category = @(1);
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd at hh:mm";
        self.createTime = [fmt stringFromDate:[NSDate date]];
        self.remindTime = self.createTime;
        self.completeTime = self.createTime;
        self.attachmentData = [@"Hello World" dataUsingEncoding:NSUTF8StringEncoding];
    }
    return self;
}
@end
