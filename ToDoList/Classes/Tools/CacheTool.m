//
//  OJCacheTool.m
//  hiyd
//
//  Created by zc on 16/5/22.
//  Copyright © 2016年 ouj. All rights reserved.
//

#import "CacheTool.h"
#import <objc/runtime.h>
#import "NSString+Extension.h"


@interface CacheTool ()

@end

@implementation CacheTool

+ (instancetype)shareCacheTool {
    static id instance_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance_ = [[self alloc] init];
        
    });
    return instance_;
}

- (void)cacheObjectInDisk:(id)obj forKey:(NSString *)key {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    
}

- (id)objectInDiskForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)removeCacheForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}


/**
 *  内存缓存
 */
- (void)cacheObjectInMemory:(id)obj forKey:(NSString *)key {
    objc_setAssociatedObject(self, (__bridge const void *)(key), obj, 1);
}

- (id)objectInMemoryForKey:(NSString *)key {
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}


- (void)cacheObjectInMemoryAndDisk:(id)obj forKey:(NSString *)key {
    
    [self cacheObjectInMemory:obj forKey:key];
    
    [self cacheObjectInDisk:obj forKey:key];
}

- (id)objectInMemoryAndDiskForKey:(NSString *)key {
    id obj = [self objectInMemoryForKey:key];
    
    if (!obj) {
        obj = [self objectInDiskForKey:key];
        if (obj) {
            
            [self cacheObjectInMemory:obj forKey:key];
        }
    }
    
    return obj;
    
}

- (void)cacheObjectInDisk:(id<NSCoding>)obj forFileName:(NSString *)fileName {
//    dispatch_get_global_queue(0, 0)
//    dispatch_async(dispatch_get_main_queue(), ^{
    
        NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        [NSKeyedArchiver archiveRootObject:obj toFile:[document stringByAppendingPathComponent:fileName] ];
    
//    });
}

- (id)objectInDiskForFileName:(NSString *)fileName {
       NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[document stringByAppendingPathComponent:fileName]];
}

- (void)removeObjectInDiskForFileName:(NSString *)fileName {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    BOOL isExist=[[NSFileManager defaultManager] fileExistsAtPath:[document stringByAppendingPathComponent:fileName]];
    if (!isExist) {
        DLog(@"no  have");
        return ;
    }else {
        DLog(@" have");
        BOOL isDelete= [fileManager removeItemAtPath:[document stringByAppendingPathComponent:fileName] error:nil];
        if (isDelete) {
            DLog(@"dele success");
        } else {
            DLog(@"dele fail");
        }
    }
}



/**
 *  内存缓存
 */
- (void)cacheObjectInMemory:(id<NSCoding>)obj forFileName:(NSString *)fileName {
    objc_setAssociatedObject(self, (__bridge const void *)(fileName), obj, 1);
    
}

- (id)objectInMemoryForFileName:(NSString *)fileName {
    return objc_getAssociatedObject(self, (__bridge const void *)(fileName));
}


- (void)cacheObjectInMemoryAndDisk:(id)obj forFileName:(NSString *)fileName {
    
    [self cacheObjectInMemory:obj forFileName:fileName];
    
    [self cacheObjectInDisk:obj forFileName:fileName];
}

- (id)objectInMemoryAndDiskForFileName:(NSString *)fileName {
    id obj = [self objectInMemoryForFileName:fileName];
    
    if (!obj) {
        obj = [self objectInDiskForFileName:fileName];
        if (obj) {
            
            [self cacheObjectInMemory:obj forFileName:fileName];
        }
    }
    
    return obj;
}

@end
