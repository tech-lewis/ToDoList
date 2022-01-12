//
//  QXB_Define.h
//  QiXiuBao_iOS
//
//  Created by zc on 2017/11/14.
//  Copyright © 2017年 qixiubao.com. All rights reserved.
//

#ifndef QXB_Define_h
#define QXB_Define_h


#pragma mark - DUBUG模式下的log输出

#if defined(DEBUG)
#define DLog(fmt, ...) NSLog((@"%s #%d " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#pragma mark - 屏幕适配

//字体适配(目前统一使用系统默认字体)
#define AdaptedFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]//[UIFont systemFontOfSize:AdaptedWidth(R)]
#define AdaptedBoldFontSize(R)  [UIFont boldSystemFontOfSize:AdaptedWidth(R)]

#define kFont(R)     [UIFont systemFontOfSize:R]
#define kBlodFont(R)  [UIFont boldSystemFontOfSize:R]

//不同屏幕尺寸适配（375.0是因为效果图为iPhone6如果不是则根据实际情况修改）
#define kScreenWidthRatio  (kScreenWidth / 375.0)
#define kScreenHeightRatio (kScreenHeight / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define kCommFooterHeight 0.000001

#define kFontM10 kFont(10)
#define kFontM11 kFont(11)
#define kFontS12 kFont(12)
#define kFontS13 kFont(13)
#define kFontX14 kFont(14)
#define kFontX15 kFont(15)
#define kFontXX16 kFont(16)
#define kFontXXl18 kFont(18)
#define kFontXXl20 kFont(20)

#define kSCREEN [UIScreen mainScreen]
#define kSCREENSCALE [UIScreen mainScreen].scale
#define kScreenHeight CGRectGetHeight([kSCREEN bounds])
#define kScreenWidth  CGRectGetWidth([kSCREEN bounds])


#pragma mark -- 获取当前版本号
#define kCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kNetworkVersion [NSString stringWithFormat:@"%@.1",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]



#pragma mark -- 广告缓存路径
#define ADImagePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject] stringByAppendingPathComponent:@"ADCache"]
#pragma mark -- OCR识别类型
#define OCR_Type (([[NSUserDefaults standardUserDefaults] integerForKey:@"ocr_type"] == 1) ? YES : NO)

#pragma mark-颜色

/************************颜色*******************************/

//蓝色 rgba(255, 31, 160, 1)
#define kBlueColor kRGB_COLOR(40, 94, 245)

#define kMainColor kRGB_COLOR(0, 0, 0)

// RGB颜色
#define kRGB_COLOR(r,g,b)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]

// RGB颜色带透明度
#define kRGBA_COLOR(r,g,b,a)  [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]

//16进制颜色
#define kRGB_SIXTEEN(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//16进制颜色
#define kUIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

//导航条颜色
#define kNavigationBarBgColor kRGBA_COLOR(255,255,255,1)

//分割线颜色
#define kLineViewColor kRGBA_COLOR(0,0,0,0.1)

//全局背景颜色
#define  kGloableBackgroundColor kRGB_COLOR(240,240,240)

//按钮不可点击颜色
#define kButtonDisableColor kRGB_COLOR(204,204,204)

//深灰色
#define kTextDarkGrayColor kRGB_COLOR(122,122,122)

//浅灰色
#define kTextLightGrayColor kRGB_COLOR(240,240,240)

// 随机颜色
#define kRandonColor kRGB_COLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#pragma mark - 其它
//弱引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define kIOS11 @available(iOS 11.0, *)
// iPhone X
#define isiPhoneX (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
#define kSafeArea 34.f
#define kStatuesBarH [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavgationBarH (kStatuesBarH + 44)
#define kTabbarHeight (isiPhoneX ? (49.f + kSafeArea) : 49.f)
#define kTabbar 49.f
#define kTabbarSafeBottomMargin   (isiPhoneX ? 34.f : 0.f)
#define kSpacing 15


#define kWindowSafeAreaInset [UIApplication sharedApplication].keyWindow.safeAreaInsets

#define kSafeAreInsets ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = kWindowSafeAreaInset;} else {insets = UIEdgeInsetsZero;} insets;})


#define kIntToString(x) [NSString stringWithFormat:@INTFORMAT,x]
#define kIntToNumber(x) [NSNumber numberWithInteger:x]
#define kStringToNumber(x) [NSNumber numberWithInteger:[x integerValue]]
#define kParseToString(x) ([x isEqual:[NSNull null]] || x ==nil)?@"":([@"undefined" isEqualToString:x]?@"":[NSString stringWithFormat:@"%@",x])
#define kIsNull(x) (([x isEqual:[NSNull null]] || x == nil || ([x isKindOfClass:[NSString class]] && [x isEqualToString:@""]))?YES:NO)
#define kIsNullObject(x) (([x isEqual:[NSNull null]] || x == nil)?YES:NO)
#define kToInt(x) (isNullObject(x)?0:[x integerValue])
#define kIsUrl(x) (isNull(x)?NO:([x isKindOfClass:[NSURL class]] || ([x isKindOfClass:[NSString class]] && ([x rangeOfString:@"http://"].length > 0)))?YES:NO)
#define kFilterSpace(x) [[x componentsSeparatedByString:@" "] componentsJoinedByString:@""]

//判断字符串是否为空
#define kStringIsNull(value) (value == nil || [value isKindOfClass:[NSNull class]] || [[value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) ? YES : NO
#define kDefaultJsonEmptyStringFor(value) kDefaultJsonEmptyStringForReplaceValue(value,@"")
#define kDefaultJsonEmptyStringForReplaceValue(value,replaceValue) if (kStringIsNull(value)) { value = replaceValue; }

//加载网络车相关的图片占位图
#define kImagePlaceholder @"placeholderImage"

//加载头像占位图
#define kImageAvatarPlaceHolder @"avatar"




#endif /* QXB_Define_h */

