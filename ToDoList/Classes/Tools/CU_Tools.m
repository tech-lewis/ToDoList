//
//  CU_Tools.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_Tools.h"

@implementation CU_Tools

//获取当前时间 format
+(NSString *)getTimeWithFormat:(NSString *)formatter{
    NSString* date;
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc ] init];
    [dateFormatter setDateFormat:formatter];
    date = [dateFormatter stringFromDate:[NSDate date]];
    NSString* timeNow = [[NSString alloc] initWithFormat:@"%@", date];
    return timeNow;
}

//时间戳转2010-22-22
+(NSString *)changeDateByTime:(NSString *)time withFormatter:(NSString *) formatter{
    if (time == nil) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    //创建一个格式对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //YYYY.MM.dd.HH.mm.ss   hh: 12小时;HH: 24小时
    [dateFormatter setDateFormat:formatter];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

//获取当前时间戳--秒
+(NSString *)getNowTimeTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

//获取当前时间戳--毫秒
+(NSString *)getNowTimeTimestampMsec{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

@end
