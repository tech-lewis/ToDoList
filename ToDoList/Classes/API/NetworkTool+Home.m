//
//  NetworkTool+Home.m
//  ImBaby
//
//  Created by zc on 2019/4/16.
//  Copyright © 2019 imbaby.com. All rights reserved.
//

#import "NetworkTool+Home.h"

@implementation NetworkTool (Home)

NSString *const API_Home = @"/mobileAPI/index.htm";

/** 请求首页数据 */
+(void)requestHomeData:(IB_HomeParam *)param completion:(NetWorkCompletionBlock)completionBlock {
    
    [[NetworkTool shareNetworkTool]BasePost:API_Home param:nil completion:^(BOOL sucess, id obj, NSString *message) {
        
        !completionBlock ? : completionBlock(sucess,obj,message);
        
    }];
    
    
}

@end
