//
//  CU_LoginController.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//  登录Controller

#import "CU_BaseViewController.h"

typedef void(^PopAndEnterLoginBlock)(void);
@interface CU_LoginController : CU_BaseViewController
@property (nonatomic, copy) PopAndEnterLoginBlock block;
@end
