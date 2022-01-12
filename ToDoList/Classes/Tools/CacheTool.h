//
//  OJCacheTool.h
//  hiyd
//
//  Created by zhangweiwei on 16/5/22.
//  Copyright © 2016年 ouj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheTool : NSObject


+ (instancetype)shareCacheTool;


/*********NSUserDefault方式缓存***********/
/**
 *  硬盘缓存
 */
- (void)cacheObjectInDisk:(id)obj forKey:(NSString *)key;
- (id)objectInDiskForKey:(NSString *)key;
- (void)removeCacheForKey:(NSString *)key;

/**
 *  内存缓存
 */
- (void)cacheObjectInMemory:(id)obj forKey:(NSString *)key;
- (id)objectInMemoryForKey:(NSString *)key;

/**
 *  硬盘缓存加内存缓存
 */
- (void)cacheObjectInMemoryAndDisk:(id)obj forKey:(NSString *)key;
- (id)objectInMemoryAndDiskForKey:(NSString *)key;

/*********NSCoding方式缓存***********/
/**
 *  硬盘缓存
 */
- (void)cacheObjectInDisk:(id<NSCoding>)obj forFileName:(NSString *)fileName;
- (id)objectInDiskForFileName:(NSString *)fileName;
- (void)removeObjectInDiskForFileName:(NSString *)fileName;
/**
 *  内存缓存
 */
- (void)cacheObjectInMemory:(id<NSCoding>)obj forFileName:(NSString *)fileName;
- (id)objectInMemoryForFileName:(NSString *)fileName;

/**
 *  硬盘缓存加内存缓存
 */
- (void)cacheObjectInMemoryAndDisk:(id<NSCoding>)obj forFileName:(NSString *)fileName;
- (id)objectInMemoryAndDiskForFileName:(NSString *)fileName;


@end
