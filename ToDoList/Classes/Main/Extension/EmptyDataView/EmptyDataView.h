//
//  EmptyDataView.h
//  TestEmptyDataView
//
//  Created by zc on 2017/11/11.
//  Copyright © 2017年 com.eenet. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 数据源 */
@protocol EmptyDataViewDataSource<NSObject>

/**
 var emptySettingTitle: String? { get }
 var emptySettingImage: UIImage? { get }
 var emptySettingDesc: String? { get }
 var emptySettingAttributedTitle: NSAttributedString? { get }
 var emptySettingAttributedDesc: NSAttributedString? { get }
 
 var emptySettingButtonNormalAttributedTitle: NSAttributedString? { get }
 var emptySettingButtonNormalTitle: String? { get }
 var emptySettingButtonNormalImage: UIImage? { get }
 var emptySettingButtonNormalBackgroundImage: UIImage? { get }
 var emptySettingButtonHighlightedTitle: String? { get }
 var emptySettingButtonHighlightedAttributedTitle: NSAttributedString? { get }
 var emptySettingButtonHighlightedImage: UIImage? { get }
 var emptySettingButtonHighlightedBackgroundImage: UIImage? { get }
 */

/** 设置标题 */
-(NSString *)emptyDataViewSettingTitle:(NSString *)title;

@optional

/** 设置富文本标题  */
-(NSAttributedString *)emptyDataViewSettingTitleAttribute:(UILabel *)titleL;

/** 设置标题颜色 */
-(UIColor *)emptyDataViewSettingTitleColor:(UIColor *)color;

/** 设置副标题 */
-(NSString *)emptyDataViewSettingSubTitle:(NSString *)subTitle;

/** 设置副标题颜色 */
-(UIColor *)emptyDataViewSettingSubTitleColor:(UIColor *)color;

/** 设置图片 */
-(NSString *)emptyDataViewSettingImageView:(NSString *)imageName;

/** 设置重新加载按钮文字 */
-(NSString *)emptyDataViewSettingButtonTitle:(NSString *)buttonTitle;

/** 设置背景色 */
-(UIColor *)emptyDataViewSettingBackGroundColor:(UIColor *)bgColor;

/** 设置emptiy的Frame，默认是全屏 */
-(CGRect)emptyDataViewSettingFrame:(CGRect)rect;

-(CGFloat)emptyDataViewSettingTitleYOffet:(CGFloat)offet;

@end

/** 代理方法 */
@protocol EmptyDataViewDataDelegate<NSObject>

@optional
/** 按钮点击 */
-(void)emptyDataViewButtonDidClick;

@end


@interface EmptyDataView : UIView


@property (nonatomic,weak) id <EmptyDataViewDataSource>dataSource;

@property (nonatomic,weak) id <EmptyDataViewDataDelegate>delegate;

-(void)showEmptyDataView:(BOOL)animated;

-(void)hideEmptyDataView:(BOOL)animated;

-(void)setEmptyDataViewStatusIsShow:(BOOL)isShow;

@end
