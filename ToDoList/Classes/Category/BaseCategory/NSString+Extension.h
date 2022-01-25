//
//  NSString+Extension.h
//  QiXiuBao_iOS
//
//  Created by zc on 2017/11/17.
//  Copyright © 2017年 qixiubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/*
 * 字符串验证
 */
//邮箱
- (BOOL)validateEmail;
/** 手机号码验证 */
- (BOOL)validateMobile;
/** 车牌号验证 */
- (BOOL)validateCarNo;
/** 用户名 */
- (BOOL)validateUserName;
/** 真实姓名 */
- (BOOL)validateTrueName;
/** 密码 */
- (BOOL)validatePassword;
/** 昵称 */
- (BOOL)validateNickname;
/** 身份证号 */
- (BOOL)validateIdentityCard;
/** 字符长度范围 */



/**
 验证字符串的长度范围

 @param minLength 最小长度
 @param maxLength 最大长度
 @return 返回Bool
 */
- (BOOL)validateStringMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength;


/** 通过时间字符串生成时间 */
- (NSDate *)dateWithFormatter:(NSString *)fmt;

/** 计算文字size */
- (CGSize)textSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font;
- (CGSize)singleLineTextWithFont:(UIFont *)font;

/*MD5大写*/
- (NSString *)MD5_UppercaseString;
/*MD5小写*/
- (NSString *)MD5_LowercaseString;
/*MD5小写16位*/
- (NSString *)MD5_16;


- (NSString *)documentPath;
- (NSString *)cachePath;
- (NSString *)tempPath;

- (BOOL)isChinese;

//判断是否包含汉字
- (BOOL)isContainChinese;


@end
