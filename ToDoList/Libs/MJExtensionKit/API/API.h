//
//  API.h
//  MJExtension
//
//  Created by mark lewis on 1/14/22.
//  Copyright (c) 2022 itcast. All rights reserved. 
//

#import <Foundation/Foundation.h>

@interface API : NSObject
// 可链式调用
@property (nonatomic, strong) id queryParameters; // 查询字典
@property (nonatomic, strong) id bodyParameters;  // 请求体字典

- (API * (^)(id))body;
- (API * (^)(id))query;

/// 公开的getter方法
+ (NSString *)developBaseUrl;
+ (NSString *)productBaseUrl;
+ (BOOL)isDevelopEnv;
@end
