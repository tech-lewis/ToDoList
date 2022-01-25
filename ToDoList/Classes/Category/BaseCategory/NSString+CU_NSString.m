//
//  NSString+CU_NSString.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "NSString+CU_NSString.h"
@implementation NSString (CU_NSString)

/**
 删除字符串里的空格
 
 @return 无空格字符串
 */
-(NSString *) deleteSpace{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""] ;
}

/**
 手机号正则表达式
 
 @return 是否正确的手机号
 */
-(Boolean) isPhoneNum{
    if (self.length!=11) {
        return NO ;
    }
    NSString *pattern = @"^1+[0123456789]+\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}



- (BOOL)mj_isPureInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
/**
 *判断一个字符串是否是一个IP地址
 **/
-(BOOL)isIPDomain {
    if (nil == self) {
        return NO;
    }
    
    NSArray *ipArray = [self componentsSeparatedByString:@"."];
    if (ipArray.count == 4) {
        for (NSString *ipnumberStr in ipArray) {
            if ([ipnumberStr mj_isPureInt]) {
                //是整数
                int ipnumber = [ipnumberStr intValue];
                if ((ipnumber>=0 && ipnumber<=255)) {
                    return YES;
                }
            }
        }
        return NO;
    }
    return NO;
}

/**
 判断是否空字符串
 
 @return 是否空字符串
 */
- (BOOL)isEmptyString {
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//检测是否为邮箱
-(BOOL)isEmail
{
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return results.count > 0;
}

+ (NSString *)emptyStr:(NSString *)str {
    
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {
        
        str = @"";
    }
    return str;
}

@end
