//
//  CU_Tools.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CU_Tools : NSObject

//获取当前时间 format
+(NSString *)getTimeWithFormat:(NSString *)formatter ;

//时间戳转2010-22-22
+(NSString *)changeDateByTime:(NSString *)time withFormatter:(NSString *) formatter;

//获取当前时间戳--秒
+(NSString *)getNowTimeTimestamp ;

//获取当前时间戳--毫秒
+(NSString *)getNowTimeTimestampMsec ;

@end

NS_ASSUME_NONNULL_END
