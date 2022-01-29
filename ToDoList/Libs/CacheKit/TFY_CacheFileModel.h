//
//  TFY_CacheFileModel.h
//  ToDoList
//
//  Created by MarkLewis on 2022/1/29.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CU_Define.h"
@interface TFY_CacheFileModel : NSObject
/**文件路径*/
@property (nonatomic, strong) NSString *filePath;
/**文件名称*/
@property (nonatomic, strong) NSString *fileName;
/**文件大小*/
@property (nonatomic, strong) NSString *fileSize;
/**文件类型（1视频、2音频、3图片、4文档）*/
@property (nonatomic, assign) TFY_CacheFileType fileType;
/**音频文件进度*/
@property (nonatomic, assign) float fileProgress;
/**音频文件进度显示*/
@property (nonatomic, assign) BOOL fileProgressShow;
@end
