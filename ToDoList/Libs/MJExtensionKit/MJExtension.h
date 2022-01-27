//
//  MJExtension.h
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJTypeEncoding.h"
#import "NSObject+MJCoding.h"
#import "NSObject+MJMember.h"
#import "NSObject+MJKeyValue.h"
// #import "API.h"



#define MJLogAllIvrs \
- (NSString *)description \
{ \
    return [self keyValues].description; \
}

#ifdef DEBUG
#define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else
#define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
