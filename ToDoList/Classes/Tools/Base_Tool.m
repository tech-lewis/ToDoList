//
//  QXB_Tool.m
//  QiXiuBao_iOS
//
//  Created by zc on 2018/2/26.
//  Copyright © 2018年 qixiubao.com. All rights reserved.
//

#import "Base_Tool.h"

@implementation Base_Tool

/** CSV文件转字典 */
+ (NSDictionary *)csvToDict:(NSString *)csvPath{
    NSError *ERR;
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString* fileContents = [NSString stringWithContentsOfFile:csvPath encoding:gbkEncoding error:&ERR];
    if(!fileContents){
        gbkEncoding = NSUTF8StringEncoding;
        fileContents = [NSString stringWithContentsOfFile:csvPath encoding:gbkEncoding error:&ERR];
    }
    // first, separate by new line
    NSArray* allLinedStrings = [fileContents componentsSeparatedByString:@"\r\n"];
    if (allLinedStrings.count <= 1) {
        allLinedStrings = [fileContents componentsSeparatedByString:@"\r"];
        if (allLinedStrings.count <= 1) {
            allLinedStrings = [fileContents componentsSeparatedByString:@"\n"];
        }
    }
    
    // then break down even further
    NSArray *keys = [allLinedStrings[0] componentsSeparatedByString:@","];
    NSMutableDictionary *citys = [NSMutableDictionary dictionary];
    for (int i = 1; i < allLinedStrings.count; i++){
        NSArray *values = [allLinedStrings[i] componentsSeparatedByString:@","];
        if (!values || values.count == 0 || [allLinedStrings[i] isEqualToString:@""]){
            continue;
        }
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (int j = 0; j < keys.count; j++){
            NSMutableString *key = [NSMutableString stringWithString:keys[j]];
            if ([key hasSuffix:@"\r"]) {
                [key deleteCharactersInRange:NSMakeRange(key.length - 2, 2)];
            }
            NSString *actkey = [key stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            NSMutableString *value = [NSMutableString stringWithString:values[j]];
            if ([value hasSuffix:@"\r"]) {
                [value deleteCharactersInRange:NSMakeRange(value.length - 2, 2)];
            }
            dict[actkey] = [value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        }
        [citys setValue:dict forKey:[NSString stringWithFormat:@"%@",values[4]]];
    }
    return citys;
}

#pragma mark - 处理浮点型小数位数
+ (NSString *)formatFloat:(CGFloat)floatValue
{
    
    //浮点型，减去一个整形，判断结果是否大于0
    CGFloat result = floatValue - (NSInteger)floatValue;
    
    if (floatValue < 1) {//如果小于1，则直接判断取一位还是两位小数
        result = floatValue;
    }
    
    if (result>0) {
    
        //判断取一位小数还是2位
        NSString *tempValue = [NSString stringWithFormat:@"%.0f",result*100];
        
        //最后一位是0
        NSString *lastChar = [tempValue substringFromIndex:1];
        
        if ([lastChar isEqualToString:@"0"]) {
            return [NSString stringWithFormat:@"%.1f",floatValue];
        }
  
        return [NSString stringWithFormat:@"%.2f",floatValue];
        
    }
    
    return [NSString stringWithFormat:@"%.0f",floatValue];
}


#pragma mark - 判断字符串是否为空

+(BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
            return YES;
    }

   if ([string isKindOfClass:[NSNull class]]) {
            return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return YES;
    }
    
    return NO;
}


/** 处理空字符串 */
+(NSString *)handleBlankString:(NSString *)string {
    return  [self isBlankString:string] ? @"" : [NSString stringWithFormat:@"%@",string];
}

//获取磁盘容量
+(CGFloat)freeDiskSpace{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    CGFloat free = [[fattributes objectForKey:NSFileSystemFreeSize] floatValue];
    return free/1024/1024;
    
}

#pragma mark 检测vin是否正确
/*
 VIN码从从第一位开始，码数字的对应值×该位的加权值，计算全部17位的乘积值相加除以11，所得的余数，即为第九位校验值   例子：   车辆识别码：UU6JA69691D713820 第九位为9为校验码，我们可以验证下是否正确。 4×8+4×7+6×6+1×5+1×4+6×3+9×2+6×10+1×9+4×8+7×7+1×6+3×5+8×4+2×3+0×0 = 350  350除以11，得31，余9，该余数9即为校验码，和识别码的校验位相同
 */
+ (BOOL)checkVinValid:(NSString *)vin {
    if (vin.length !=17) {
        return false;
    }
    NSString *vinStr = vin.uppercaseString;
    
    NSDictionary * dic=@{@"0":@(0),@"1":@(1),@"2":@(2),@"3":@(3),@"4":@(4),@"5":@(5),@"6":@(6),@"7":@(7),@"8":@(8),@"9":@(9),@"A":@(1),@"B":@(2),@"C":@(3),@"D":@(4),@"E":@(5),@"F":@(6),@"G":@(7),@"H":@(8),@"J":@(1),@"K":@(2),@"L":@(3),@"M":@(4),@"N":@(5),@"P":@(7),@"R":@(9),@"S":@(2),@"T":@(3),@"U":@(4),@"V":@(5),@"W":@(6),@"X":@(7),@"Y":@(8),@"Z":@(9)};
    
    int pw[]= {8,7,6,5,4,3,2,10,0,9,8,7,6,5,4,3,2};
    
    vinStr = vinStr.uppercaseString;
    int sum=0;
    for (int i=0; i<vinStr.length; i++) {
        NSString * cur=[vinStr substringWithRange:NSMakeRange(i, 1)];
        sum += [dic[cur] intValue]*pw[i];
    }
    
    NSInteger crc = [vinStr characterAtIndex:8];
    if (crc == 88) {  //88为X的十进制  第九位为X的时候，运算出来的结果为10
        crc = 10;
    }else{
        crc = [[vinStr substringWithRange:NSMakeRange(8, 1)] integerValue];
    }
    int mo=sum%11;   //vin检测规则为加权值％11
    
    if (mo == crc) {
        return true;
    }
    
    return false;
}

//判断是否是数字
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否是小数
+ (BOOL)isPureFloat:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//判断是否只包含数字和字母
+(BOOL)checkOnlyNumberOrChar:(NSString *)string {
    NSString *regex = @"((?=.*\\d)(?=.*[a-zA-Z]))[\\da-zA-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

//正则去除网络标签
+(NSString *)getZZwithString:(NSString *)string{
    
    if ([string isKindOfClass:[NSString class]] == NO) {
        string = @"";
    }
    
    string = [string stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

+(NSString *)getTimeStamp {
    NSDate *now = [NSDate date];
    return [NSString stringWithFormat:@"%0.f",[now timeIntervalSince1970]*1000];
}

+ (NSString *)getTime {
    NSDate *fromdate=[NSDate date];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:fromdate];
    return string;
}

+(NSMutableAttributedString *)stringFromatToAttributTitle:(NSString *)title titleColor:(UIColor *)titleColor subTitle:(NSString *)subTitle subTitleColor:(UIColor *)subTitleColor {
    
    title = [self handleBlankString:title];
    subTitle = [self handleBlankString:subTitle];
    
    NSString *content = [NSString stringWithFormat:@"%@%@",title,subTitle];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:content];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:titleColor} range:[content rangeOfString:title]];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:subTitleColor} range:[content rangeOfString:subTitle]];
    return attributeString;
}

+ (UIImage *)addWatermarkToImage:(UIImage *)image {
    NSString *qixiubaoText = @"汽修宝";
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize imageSize = CGSizeMake(image.size.width*scale, image.size.height*scale);
    UIGraphicsBeginImageContext(imageSize);
    [image drawInRect:CGRectMake(0, 0, image.size.width*scale, image.size.height*scale)];
    NSShadow *textShaw = [[NSShadow alloc]init];
    textShaw.shadowBlurRadius = 5.0f;
    textShaw.shadowColor = [UIColor blackColor];
    textShaw.shadowOffset  = CGSizeMake(5, 5);
    NSDictionary *qixiuDict = @{
                                NSFontAttributeName : [UIFont boldSystemFontOfSize:13 * imageSize.width / [UIScreen mainScreen].bounds.size.width],
                                NSShadowAttributeName:textShaw,
                                NSVerticalGlyphFormAttributeName:@(0),
                                NSForegroundColorAttributeName : [UIColor colorWithRed:255.0/ 255.0 green:255.0/ 255.0 blue:255.0/ 255.0 alpha:0.6]
                                };
    CGSize qiXiuRect = [qixiubaoText sizeWithAttributes:qixiuDict];
    [qixiubaoText drawAtPoint:CGPointMake(imageSize.width - qiXiuRect.width, imageSize.height - qiXiuRect.height) withAttributes:qixiuDict];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}


+(void)callPhone:(NSString *)phone {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]]];
}

@end
