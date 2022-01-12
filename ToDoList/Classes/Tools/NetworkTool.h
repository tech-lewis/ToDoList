//
//  Rec_NetworkTool.h
//  RecruitStudent_iOS
//
//  Created by zc on 2017/3/5.
//  Copyright © 2017年 com.eenet. All rights reserved.
//

#import "AFNetworking.h"

typedef void(^NetWorkCompletionBlock)(BOOL sucess,id obj,NSString *message);

@interface NetworkTool : AFHTTPSessionManager
+ (instancetype)shareNetworkTool;


-(NSURLSessionDataTask *)BasePost:(NSString *)url param:(NSDictionary *)param completion:(NetWorkCompletionBlock)completion;

-(NSURLSessionDataTask *)BaseGet:(NSString *)url param:(NSDictionary *)param completion:(NetWorkCompletionBlock)completion;




@end
