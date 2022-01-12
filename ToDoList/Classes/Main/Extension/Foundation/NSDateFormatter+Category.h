//
//  NSDateFormatter.h
//  QiXiuBao_iOS
//
//  Created by Ezio_Chiu on 2018/4/10.
//  Copyright © 2018 qixiubao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Category)

+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

@end
