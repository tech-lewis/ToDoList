//
//  NSString+CU_NSString.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CU_NSString)
- (BOOL)mj_isPureInt;
/**
 删除字符串里的空格
 
 @return 无空格字符串
 */
-(NSString *) deleteSpace ;


/**
 手机号正则表达式
 
 @return 是否正确的手机号
 */
-(Boolean) isPhoneNum ;

/**
 *判断一个字符串是否是一个IP地址
 **/
-(BOOL)isIPDomain;

/**
 判断是否空字符串
 
 @return 是否空字符串
 */
- (BOOL)isEmptyString ;

/**
 检测是否为邮箱
 
 @return 是否为邮箱
 */
-(BOOL) isEmail ;

+ (NSString *)emptyStr:(NSString *)str ;

@end

NS_ASSUME_NONNULL_END
