//
//  CU_CacheManager.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_CacheManager.h"

@implementation CU_CacheManager

#pragma mark - NSKeyedArchiver 缓存浏览数据 位置：Documents
/* NSKeyedArchiver 归档实现本地缓存
 * @param obj 缓存对象
 * @param key key值
 */
+(BOOL)archiveObject:(id)obj forKey:(NSString *)key{
    NSString * filePath = [self filePathForKey:key];
    return [NSKeyedArchiver archiveRootObject:obj toFile:filePath];
}
+(id)unArchiveObjectForKey:(NSString *)key{
    NSString * filePath = [self filePathForKey:key];
    return[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}
+(BOOL)removeObjectForKey:(NSString *)key{
    NSString * filePath = [self filePathForKey:key];
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

#pragma mark - NSUserDefaults 记录设置信息 位置：默认
/* NSUserDefaults 偏好设置存储
 * @param value 缓存值
 * @param key key值
 */
+(void)setValue:(id)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}
+(id)valueForKey:(NSString *)key{
    return  [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
+(void)removeValueForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

#pragma mark - 计算目录大小
+(float)cacheSize{
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)firstObject];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:filePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:filePath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[filePath stringByAppendingPathComponent:fileName];
            if([fileManager fileExistsAtPath:absolutePath]){
                long  size=[fileManager attributesOfItemAtPath:absolutePath error:nil].fileSize;
                folderSize += size/1024.0;
            }
        }
    }
    // 返回单位 /K
    return folderSize;
}
+(void)clearAllCache{
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)firstObject];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:filePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[filePath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
#pragma mark - 文件路径
+(NSString *) filePathForKey:(NSString *)key{
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)firstObject];
    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data",key]];
    //filePath = [filePath stringByAppendingPathComponent:@".data"];
    NSLog(@"filePath = %@",filePath);
    return filePath;
}

@end
