//
//  NoteCacheTools.h
//  ToDoList
//
//  Created by MarkLewis on 2021/12/26.
//  Copyright © 2021 mark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class NoteListModel;
@interface NoteCacheTools : NSObject
/**
 *  缓存一条记录
 *
 *  @param status 需要缓存的微博数据
 */
+ (void)addStatus:(NoteListModel *)item;

/**
 *  缓存N条数据
 *
 *  @param statusArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)item;

+ (NSArray<NoteListModel *> *)findAllNotes;

@end

NS_ASSUME_NONNULL_END
