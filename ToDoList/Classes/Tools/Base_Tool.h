//
//  QXB_Tool.h
//  QiXiuBao_iOS
//
//  Created by zc on 2018/2/26.
//  Copyright © 2018年 qixiubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base_Tool : NSObject


/**
 图片加水印
 */
+ (UIImage *)addWatermarkToImage:(UIImage *)image;

/** CSV文件转字典 */
+ (NSDictionary *)csvToDict:(NSString *)csvPath;

/**
 处理浮点型保留2位小数，去调小数后多余的0
    999.880 > 999.88
    999.00 > 999;
 */
+ (NSString *)formatFloat:(CGFloat)floatValue;

//判断是否是空字符串
+ (BOOL) isBlankString:(NSString *)string;


/** 处理空字符串 */
+(NSString *)handleBlankString:(NSString *)string;


/** 获取时间-时间戳格式 */
+(NSString *)getTimeStamp;

/** 获取时间-yyyy-MM-dd HH:mm:ss格式 */
+ (NSString *)getTime;

//获取磁盘容量
+ (CGFloat)freeDiskSpace;

+ (BOOL)checkVinValid:(NSString *)vin;

//正则去除网络标签
+(NSString *)getZZwithString:(NSString *)string;

//判断是否是数字
+ (BOOL)isPureInt:(NSString*)string;

//判断是否是小数
+ (BOOL)isPureFloat:(NSString*)string;

//判断是否只包含数字和字母
+(BOOL)checkOnlyNumberOrChar:(NSString *)string;

+(NSMutableAttributedString *)stringFromatToAttributTitle:(NSString *)title titleColor:(UIColor *)titleColor subTitle:(NSString *)subTitle subTitleColor:(UIColor *)subTitleColor;

+(void)callPhone:(NSString *)phone;

@end
