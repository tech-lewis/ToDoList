//
//  NetworkTool+Home.h
//  ImBaby
//
//  Created by zc on 2019/4/16.
//  Copyright © 2019 imbaby.com. All rights reserved.
//

#import "NetworkTool.h"
#import "IB_HomeParam.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkTool (Home)

/** 请求首页数据 */
+(void)requestHomeData:(IB_HomeParam *)param completion:(NetWorkCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
