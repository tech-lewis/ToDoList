//
//  CU_CacheManager.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CU_CacheManager : NSObject

#pragma mark - NSKeyedArchiver 缓存浏览数据 位置：Documents
/* NSKeyedArchiver 归档实现本地缓存
 * @param obj 缓存对象(常量转NSNumber对象)
 * @param key key值
 */
+(BOOL)archiveObject:(id)obj forKey:(NSString *)key;
+(id)unArchiveObjectForKey:(NSString *)key;
+(BOOL)removeObjectForKey:(NSString *)key;

#pragma mark - NSUserDefaults 记录设置信息 位置：默认 Library/Preferences
/* NSUserDefaults 偏好设置存储
 * @param value 缓存值
 * @param key key值
 */
+(void)setValue:(id)value forKey:(NSString *)key;
+(id)valueForKey:(NSString *)key;
+(void)removeValueForKey:(NSString *)key;

#pragma mark - 计算目录大小
+(float)cacheSize;
+(void)clearAllCache;

@end

NS_ASSUME_NONNULL_END
