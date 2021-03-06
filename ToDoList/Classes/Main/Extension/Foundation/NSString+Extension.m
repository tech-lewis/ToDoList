//
//  NSString+Extension.m
//  QiXiuBao_iOS
//
//  Created by zc on 2017/11/17.
//  Copyright © 2017年 qixiubao.com. All rights reserved.
//

#import "NSString+Extension.h"
#import "Base_Define.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)


#pragma mark -字符串验证
//邮箱
- (BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//手机号码验证
- (BOOL)validateMobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

//车牌号验证
- (BOOL)validateCarNo {
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    // DLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}


//用户名
- (BOOL)validateUserName {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}

//真实姓名
- (BOOL)validateTrueName {
    NSString *trueNameRegex = @"^([\u4E00-\u9FA5]+|[a-zA-Z]+)$";
    NSPredicate *trueNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",trueNameRegex];
    BOOL B = [trueNamePredicate evaluateWithObject:self];
    return B;
}

//密码
- (BOOL)validatePassword {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//昵称
- (BOOL)validateNickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

//身份证号
- (BOOL)validateIdentityCard {
    if (self.length != 18) return NO;
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)validateStringMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength {
    return (self.length >= minLength && self.length <= maxLength);
}

#pragma mark -时间相关
- (NSDate *)dateWithFormatter:(NSString *)fmt {
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    dateFmt.dateFormat = fmt;
    return [dateFmt dateFromString:self];
}

#pragma mark -文本size

- (CGSize)textSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGSize)singleLineTextWithFont:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName : font}];
}


- (NSString *)MD5_UppercaseString {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    
    
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    
    return [NSString stringWithString:mutableString].uppercaseString;
    
}

- (NSString *)MD5_LowercaseString {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    
    
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    
    return [NSString stringWithString:mutableString].lowercaseString;
    
}

- (NSString *)MD5_16 {
    NSString *md5 = [self MD5_LowercaseString];
    md5 = [md5 substringWithRange:NSMakeRange(8, 16)];
    return md5;
}

- (NSString *)documentPath {
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [document stringByAppendingPathComponent:self];
}

- (NSString *)cachePath {
    
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [cache stringByAppendingPathComponent:self];
}


- (NSString *)tempPath {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self];
}

//判断是否为汉字
- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

//判断是否包含汉字
- (BOOL)isContainChinese {
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}


+ (NSString *)QXBStringRemoveDuplicates:(NSString *)string1 AndString:(NSString *)string2 {
    NSString *model = nil;
    if (!kIsNull(string1) && !kIsNull(string2)  && [string2 containsString:string1]) {
        NSString *modelName = [string2 substringFromIndex:string1.length];
        model = [NSString stringWithFormat:@"%@ %@",string1,modelName];
    } else {
        model = [NSString stringWithFormat:@"%@ %@",string1,string2];
    }
    return model;
}


@end
