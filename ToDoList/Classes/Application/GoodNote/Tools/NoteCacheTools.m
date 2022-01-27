//
//  NoteCacheTools.m
//  ToDoList
//
//  Created by MarkLewis on 2021/12/26.
//  Copyright © 2021 mark. All rights reserved.
//

#import "NoteCacheTools.h"
#import "NoteListModel.h"
#import "fmdb.h"
@implementation NoteCacheTools
static FMDatabaseQueue *_queue;


+ (void)setup
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/todolist.sqlite"];
    NSString *pathTmp = [[NSBundle mainBundle] pathForResource:@"todolist.db" ofType:nil];
    // 1.拷贝原生数据库文件
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:path])
    {
        NSError *copyError = NULL;
        // 拷贝文件到沙盒
        [fileMgr copyItemAtPath:pathTmp toPath:path error:&copyError];
        if (copyError == NULL) NSLog(@"拷贝数据库文件成功");
    }
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
}

+ (void)addStatus:(NoteListModel *)item
{
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        // NSString *tableName = @"default_note";
        NSNumber *idStr = item.idstr;
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd at hh:mm";
        // NSString *creteTime = [fmt stringFromDate:[NSDate date]];
        NSLog(@"");
        
        // 2.存储数据detail; // category create remind complete
        [db executeUpdate:@"insert into default_note (id, title, subtitle, detail, category, createTime, remindTime, completeTime, attachmentData) values(? , ? , ? , ? , ? , ? , ? , ? , ?);", idStr, item.title, item.subtitle, item.detail, item.category, item.createTime, item.remindTime, item.completeTime, item.attachmentData];
    }];
    
    [_queue close];
}

+ (void)addStatuses:(NSArray *)items
{
    for (NoteListModel *item in items)
    {
        [self addStatus:item];
    }
}

+ (NSArray *)findAllNotes
{
    [self setup];
    NSLog(@"start loading SQL=%@", [NSDate date]);
    // 1.定义数组
    __block NSMutableArray *dataList = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        dataList = [NSMutableArray array];
        
        // accessToken
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"select * from default_note;"];
        int startID = 1;
        while (rs.next)
        {
            // NSData *data = [rs dataForColumn:@"id"];
            // 字典转模型
            NoteListModel *item = [NoteListModel new];
            item.idstr = @([rs intForColumn:@"id"]);
            item.title = [[NSString alloc] initWithData:[rs dataForColumn:@"title"] encoding:NSUTF8StringEncoding];
            item.subtitle = [[NSString alloc] initWithData:[rs dataForColumn:@"subtitle"] encoding:NSUTF8StringEncoding];
            item.detail = [[NSString alloc] initWithData:[rs dataForColumn:@"detail"] encoding:NSUTF8StringEncoding];
            // item.catrgory = [NSNumber ];
            // int test = [rs intForColumn:@"category"];
            item.category = @([rs intForColumn:@"category"]);
            item.createTime = [[NSString alloc] initWithData:[rs dataForColumn:@"createTime"] encoding:NSUTF8StringEncoding];
            item.remindTime = [[NSString alloc] initWithData:[rs dataForColumn:@"remindTime"] encoding:NSUTF8StringEncoding];
            item.completeTime = [[NSString alloc] initWithData:[rs dataForColumn:@"completeTime"] encoding:NSUTF8StringEncoding];
            [dataList addObject:item];
            startID += 1;
        }
        NSLog(@"finsh loading SQL=%@ %iitems ", [NSDate date], startID);
    }];
    [_queue close];
    dataList = dataList.reverseObjectEnumerator.allObjects.mutableCopy;
    // 3.返回数据
    return dataList;
}
@end
