//
//  API.m
//  MJExtension
//
//  Created by mark lewis on 1/14/22.
//  Copyright (c) 2022 itcast. All rights reserved.
//

#import "API.h"
// 开发环境的基地址
NSString *const developBaseUrl = @"";

// 生产环境的基地址
NSString *const productBaseUrl = @"";
BOOL isDevelopEnv = true;
typedef enum {
    GET,
    POST,
    PUT,
    DELETE
} HTTPMethod;

@interface API()
@property (nonatomic, assign) HTTPMethod method;
/* 私有的请求路径*/
@property (nonatomic, copy) NSString *path;

@end
@implementation API
@synthesize method = _method;
@synthesize path = _path;
@synthesize bodyParameters = _bodyParameters;
@synthesize queryParameters = _queryParameters;


- (API *(^)(id))query {
    // weak_Self;
    return ^(id parameters) {
        // strong_Self;
        self.queryParameters = parameters;
        return self;
    };
}

- (API *(^)(id))body {
    return ^(id parameters) {
        self.bodyParameters = parameters;
        return self;
    };
}
/// INIT
- (id)initWithMethod: (HTTPMethod)method path:(NSString *)url version:(NSString *)version customPath:(NSString *)customPath
{
    NSString *base = [API isDevelopEnv] ? [API developBaseUrl] : [API productBaseUrl];
    self = [super init];
    if (self) {
        self.method = method;
        if (!customPath) {
            self.path = customPath;
        } else {
            self.path = base;
        }
    }
    /// API的版本号 可以拼接字符串path+version
    
    if (!url) {
        // 接在后面
        self.path = [NSString stringWithFormat:@"%@%@", _path, url];
    }
    return self;
}

+ (NSString *)developBaseUrl {
    return developBaseUrl;
}
+ (NSString *)productBaseUrl {
    return productBaseUrl;
}
+ (BOOL)isDevelopEnv {
    return isDevelopEnv;
}

- (HTTPMethod)method {
    return self.method;
}
@end
