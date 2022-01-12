//
//  Rec_NetworkTool.m
//  RecruitStudent_iOS
//
//  Created by zc on 2017/3/5.
//  Copyright © 2017年 com.eenet. All rights reserved.
//

#import "NetworkTool.h"
#import "sys/utsname.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "NetworkStatusUtil.h"
//#import "PRO_AccountModel.h"
#import "Base_HUDTool.h"
NSString *const kBaseUrl = @"http://113.106.125.42:8084";
@implementation NetworkTool

+ (instancetype)shareNetworkTool {
    static NetworkTool *instance_;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
   
        instance_ = [[NetworkTool alloc]initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        
        NSMutableSet *contentTypes = [responseSerializer.acceptableContentTypes mutableCopy];
        
        [contentTypes addObject:@"text/plain"];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"application/json"];
        [contentTypes addObject:@"text/json"];
        [contentTypes addObject:@"image/jpeg"];
        [contentTypes addObject:@"application/octet-stream"];
        responseSerializer.acceptableContentTypes = contentTypes;
        instance_.responseSerializer = responseSerializer;
        [instance_.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
        [instance_.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
      
        
        instance_.requestSerializer.timeoutInterval = 15.f;
        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        [securityPolicy setAllowInvalidCertificates:YES];
        [instance_ setSecurityPolicy:securityPolicy];
        
        
        instance_.securityPolicy.allowInvalidCertificates = YES;
        instance_.securityPolicy.validatesDomainName = NO;//不验证证书的域名
        
        //设置请求超时时间
        
        [instance_ addHeaderParameters];
        
        
    });
    return instance_;
}




-(NSURLSessionDataTask *)BasePost:(NSString *)url param:(NSDictionary *)param completion:(NetWorkCompletionBlock)completion {
    //设置touken
    
//    if ([PRO_AccountModel currentAccountModel]) {
//        NSString *token = [PRO_AccountModel currentAccountModel].appToken ;
        [self.requestSerializer setValue:@"9999" forHTTPHeaderField:@"Imbaby-Uid"];
//        DLog(@"token:%@",token );
//    }else {
//        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"appToken"];
//    }
    
    DLog(@"url:%@ \n param:%@",url,param);
    
//    [self dynamicHeader];
    
    return [self POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
      
            completion(NO,responseObject,responseObject[@"msg"]);
        
        }else {
            [Base_HUDTool showTextHudInBottomWithMessage:@"服务器繁忙" WithView:[UIApplication sharedApplication].keyWindow];
            completion(NO,@{@"":@""},@"");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [Base_HUDTool showTextHudInBottomWithMessage:@"服务器繁忙" WithView:[UIApplication sharedApplication].keyWindow];
        completion(NO,nil,@"请求出错了");
    }];
    
}


-(NSURLSessionDataTask *)BaseGet:(NSString *)url param:(NSDictionary *)param completion:(NetWorkCompletionBlock)completion {
    
    //设置touken
//    if ([PRO_AccountModel currentAccountModel]) {
//        NSString *token = [PRO_AccountModel currentAccountModel].appToken ;
//        [self.requestSerializer setValue:token forHTTPHeaderField:@"appToken"];
//        DLog(@"token:%@",token );
//    }else {
//         [self.requestSerializer setValue:@"" forHTTPHeaderField:@"appToken"];
//    }
    
    DLog(@"url:%@ \n param:%@",url,param);
    
    [self dynamicHeader];
 

    return [self GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSInteger status = [responseObject[@"status"]integerValue];
            
            if (status == 1) {
                  completion(YES,responseObject,responseObject[@"msg"]);
            }else {
                [Base_HUDTool showTextHudInBottomWithMessage:responseObject[@"msg"] WithView:[UIApplication sharedApplication].keyWindow];
                completion(NO,responseObject,responseObject[@"msg"]);
            }
           
        }else {
            
            [Base_HUDTool showTextHudInBottomWithMessage:@"服务器繁忙" WithView:[UIApplication sharedApplication].keyWindow];
             completion(NO,@{@"":@""},@"");
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [Base_HUDTool showTextHudInBottomWithMessage:@"服务器繁忙" WithView:[UIApplication sharedApplication].keyWindow];
        completion(NO,nil,@"请求出错了");
    }];
}


#pragma mark - 基础设置


- (void)dynamicHeader{
    [self.requestSerializer setValue:[self getNetType] forHTTPHeaderField:@"nettype"];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];//转为字符型取整数部分
    [self.requestSerializer setValue:timeString forHTTPHeaderField:@"pKey"];
}

- (void)addHeaderParameters{
    
    [self.requestSerializer setValue:@"2" forHTTPHeaderField:@"appId"];
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = infoDict[key];
    [self.requestSerializer setValue:currentVersion forHTTPHeaderField:@"clientVer"];
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    [self.requestSerializer setValue:identifierForVendor forHTTPHeaderField:@"imei"];
    //[self.mgr.requestSerializer setValue:@"" forHTTPHeaderField:@"macAddr"];
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    [self.requestSerializer setValue:deviceString forHTTPHeaderField:@"model"];
    NSString* versionNum =[UIDevice currentDevice].systemVersion;
    [self.requestSerializer setValue:versionNum forHTTPHeaderField:@"osVer"];
    [self.requestSerializer setValue:@"200" forHTTPHeaderField:@"chanId"];
    [self.requestSerializer setValue:[self checkCarrier] forHTTPHeaderField:@"operator"];
    //        [self.mgr.requestSerializer setValue:@"" forHTTPHeaderField:@"secretKey"];
    [self.requestSerializer setValue:identifierForVendor forHTTPHeaderField:@"uuid"];
}



// 生成惟一随机数
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


/* 关于获取运营商信息，需通过 CoreTelephony Framework 中的 CTTelephonyNetworkInfo 和 CTCarrier 类型。这些都在 iOS 4.0 后就有了。
 
 import 必要的 header ：
 
 #import <CoreTelephony/CTCarrier.h>
 
 #import <CoreTelephony/CTTelephonyNetworkInfo.h>
 
 何判断当前网络的运营商
 
 */

// 用来辨别设备所使用网络的运营商

- ( NSString *)checkCarrier
{
    NSString *ret = [[ NSString alloc ] init ];
    CTTelephonyNetworkInfo *info = [[ CTTelephonyNetworkInfo alloc ] init ];
    CTCarrier *carrier = [info subscriberCellularProvider ];
    
    if (carrier == nil ) {
        return @"4";//@"未知" ;
    }
    
    NSString *code = [carrier mobileNetworkCode];
    
    if ([code  isEqual : @"" ]) {
        return @"4";//@"未知" ;
    }
    
    if ([code isEqualToString : @"00" ] || [code isEqualToString : @"02" ] || [code isEqualToString : @"07" ]) {
        ret = @"1";//@"中国移动" ;
    }
    
    if ([code isEqualToString : @"01" ]|| [code isEqualToString : @"06" ] ) {
        ret = @"2";//@"中国联通" ;
    }
    
    if ([code isEqualToString : @"03" ]|| [code isEqualToString : @"05" ] ) {
        ret = @"3";//@"中国电信" ;;
    }
    
    //    NSLog ( @"%@" ,ret);
    return ret;
}


- (NSString *)getNetType{
    
    NSString * netType = [NetworkStatusUtil getNetWorkStates];
    if ([netType isEqualToString:@"WIFI"]) {
        return @"1";
    }else if([netType isEqualToString:@"2G"]){
        return @"2";
    }else if([netType isEqualToString:@"3G"]){
        return @"3";
    }else if([netType isEqualToString:@"4G"]){
        return @"4";
    }else{
        return @"9";
    }
}

@end
