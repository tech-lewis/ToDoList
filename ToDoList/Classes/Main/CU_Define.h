//
//  CU_Define.h
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#ifndef CU_Define_h
#define CU_Define_h
// static NSString *const TFY_CacheFileTitle = @"缓存文件";

/**
 *  默认显示文件
 *  视频：.avi、.dat、.mkv、.flv、.vob、.mp4、.m4v、.mpg、.mpeg、.mpe、.3pg、.mov、.swf、.wmv、.asf、.asx、.rm、.rmvb
 *  音频：.wav、.aif、.au、.mp3、.ram、.wma、.mmf、.amr、.aac、.flac、.midi、.mp3、.oog、.cd、.asf、.rm、.real、.ape、.vqf
 *  图片：.jpg、.png、.jpeg、.gif、.bmp
 *  文档：.txt、.sh、.doc、.docx、.xls、.xlsx、.pdf、.hlp、.wps、.rtf、.html、@".htm", .iso、.rar、.zip、.exe、.mdf、.ppt、.pptx、.apk
 */

/// 文件类型
typedef NS_ENUM(NSInteger, TFY_CacheFileType)
{
    /// 文件类型 0未知
    TFY_CacheFileTypeUnknow = 0,
    
    /// 文件类型 1视频
    TFY_CacheFileTypeVideo = 1,
    
    /// 文件类型 2音频
    TFY_CacheFileTypeAudio = 2,
    
    /// 文件类型 3图片
    TFY_CacheFileTypeImage = 3,
    
    /// 文件类型 4文档
    TFY_CacheFileTypeDocument = 4,
};

#pragma mark - 自定义Log
#ifdef DEBUG
#define kNSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define kNSLog(...)
#endif

#pragma mark - 字体
/************************字体*******************************/

//不同屏幕尺寸适配（414，736是因为效果图为iPhone6plus如果不是则根据实际情况修改）
/*
 宽x高    分辨率      型号                 尺寸
 320x480  640x960   iPhone4,4s           3.5寸     @2x
 320x568  640x1136  iPhone5,5s,5c,se     4寸       @2x
 375x667  750x1334  iPhone6,6s,7,8       4.7寸     @2x
 414x736  1242x2208 iPhone6P,6sP,7P,8P   5.5寸     @3x（1242x2208-设计版,1125x2001-放大版,1080x1920-物理版）
 375x812  1125x2436 iPhone X             5.8寸     @3x
 375x812  1125x2436 iPhone XS            5.8寸     @3x
 414x896  828x1792  iPhone XR            6.1寸     @3x
 414x896  1242x2688 iPhone XS Max        6.5寸     @3x
 **/
#define IsIphone6P          kSCREEN_WIDTH==414
#define IsIphone5           kSCREEN_WIDTH==320
#define IsIphoneX           kSCREEN_HEIGHT==812||kSCREEN_HEIGHT==896

//字体--Plus放大比例1.5 iPhone5缩小0.85 iPhone6等比1，以iPhone6为设计稿
//字体--Plus放大比例1 iPhone5缩小0.56 iPhone6缩小0.66，以Plus为设计稿
#define SizeScale           (IsIphone6P ? 1.1 : (IsIphone5 ? 0.85:1))

#define SYSTEM_FONT_SIZE(fontSize) [UIFont systemFontOfSize:fontSize]
//可直接填设计稿字体像素单位
#define kFont(value)        [UIFont systemFontOfSize:value*SizeScale]
#define kBoldFont(value)    [UIFont boldSystemFontOfSize:value*SizeScale]
//宽高
#define kAdaptedWidth(x) ((x) * SizeScale)
#define kAdaptedHeight(x) ((x) * SizeScale)
//px转pt
#define kPxToPt(value)      value*3/4


#pragma mark - 颜色

/************************颜色*******************************/
// RGB颜色
#define kRGB_COLOR(r,g,b)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
// RGB颜色带透明度
#define kRGBA_COLOR(r,g,b,a)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
// 随机颜色
#define kRANDOM_COLOR RGB_COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//16进制颜色
#define kRGB_SIXTEEN(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//分割线颜色
#define kLINE_COLOR kRGBA_COLOR(0,0,0,0.2)
//背景色
#define kBACKGROUND_COLOR kRGB_COLOR(240, 242, 245)
//主题色
#define kMAIN_COLOR kRGB_COLOR(90, 121, 229)
//蓝色
#define kBLUE_COLOR kRGB_COLOR(57, 143, 251)
//线的颜色
#define LINERGBA [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]

/************************空值判断*******************************/
#pragma mark - 对象为空判断
//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#pragma mark - UserDefault
/**
 *  the saving objects      存储对象
 *
 *  @param __VALUE__ V
 *  @param __KEY__   K
 *
 *  @return
 */
#define kUserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#define kUserDefaultSetBoolForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setBool:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *  get the saved objects       获得存储的对象
 */
#define kUserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]
#define kUserDefaultBoolForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] boolForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define kUserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

#pragma mark - 系统版本
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/************************其他常用*******************************/

#pragma mark - 其他常用
//状态栏+导航栏高度
#define kNavigationAndStatusHeight self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height

#define kBottomToolBarHeight 44
#define kTabbarHeight (IsIphoneX?83:49)
//状态栏高度
#define kSTATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define kNAVIGATION_BAR_HEIGHT self.navigationController.navigationBar.frame.size.height
//底部安全区域
#define kBOTTOM_HEIGHT (IsIphoneX ? 34:0)
//View视图中获取状态栏+导航栏高度
#define kViewNavAndStatusHeight (IsIphoneX ? 88:64)

#define SCREEN [UIScreen mainScreen]
#define kSCREEN_WIDTH CGRectGetWidth([SCREEN bounds])
#define kSCREEN_HEIGHT CGRectGetHeight([SCREEN bounds])

//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//App Build号
#define kAppBulidVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
//弱引用/强引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

#define kDefaultImg [UIImage imageNamed:@"answering_question_image_placeholder"]
#define kEmptyImg [UIImage imageNamed:@"empty"]

#define SWNOTEmptyDictionary(X) (NOTNULL(X)&&[X isKindOfClass:[NSDictionary class]]&&[[X allKeys]count])
#define NOTNULL(x) ((![x isKindOfClass:[NSNull class]])&&x)
#define SWNOTEmptyStr(X) (NOTNULL(X)&&[X isKindOfClass:[NSString class]]&&((NSString *)X).length)

//语言国际化
#define kLocalLanguage(key) [[CU_ChangeLanguageTool bundle] localizedStringForKey:(key) value:nil table:@"CU_Language"]


#endif /* CU_Define_h */
