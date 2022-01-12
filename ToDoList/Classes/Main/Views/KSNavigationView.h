//
//  KSNavigationView.h
//  KuShow
//
//  Created by iMac on 2017/6/6.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSNavigationButtonItem : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *highlightedImage;
@property (nonatomic,strong) UIImage *disabledImage;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,assign) UIEdgeInsets imageInsets;
@property (nonatomic,assign) UIEdgeInsets titleInserts;
@property (nonatomic,assign, getter=isEnabled) BOOL enabled;
@property (nonatomic,copy) void(^handle)(KSNavigationButtonItem * buttonItem);

+ (instancetype)itemWithTitle:(NSString *)title handle:(void(^)(KSNavigationButtonItem * item))handle;;
+ (instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)color handle:(void(^)(KSNavigationButtonItem * item))handle;;
- (instancetype)initWithTitle:(NSString *)title handle:(void(^)(KSNavigationButtonItem * item))handle;;


+ (instancetype)itemWithImage:(UIImage *)image handle:(void(^)(KSNavigationButtonItem * item))handle;
- (instancetype)initWithImage:(UIImage *)image handle:(void(^)(KSNavigationButtonItem * item))handle;

+ (instancetype)itemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage handle:(void(^)(KSNavigationButtonItem * item))handle;
- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage handle:(void(^)(KSNavigationButtonItem * item))handle;

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage handle:(void(^)(KSNavigationButtonItem * item))handle;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage handle:(void(^)(KSNavigationButtonItem * item))handle;

@end


@interface KSNavigationView : UIView


// 状态栏
@property (nonatomic,strong) UIImageView *statusBar;

@property (nonatomic,strong) UILabel *titleLabel;
/**** 背景色默认白色，也可以设置图片，可设置alpha透明度 ****/
@property (nonatomic,strong) UIImageView *backgroundView;
@property (nonatomic,strong) UIImageView *shadowView;

@property (nonatomic,strong) UIImage *backgroundImage;
@property (nonatomic,strong) UIImage *shadowImage;
@property (nonatomic,strong) UIImage *statusBarImage;

@property (nonatomic,assign) CGFloat itemSpacing;
@property (nonatomic,assign) CGFloat itemInset;

/*** 设置背景透明度，同时设置backgroundView和shadowView, statusBar **/
@property (nonatomic,assign) CGFloat backgroundAlpha;


/** 设置title */
@property (nonatomic,copy) NSString *title;
/** 设置富文本title */
@property (nonatomic,strong) NSAttributedString *attributedTitle;
@property (nonatomic,strong) UIView *titleView;

/** 左右添加单个item */
@property (nonatomic,strong) KSNavigationButtonItem *leftButtonItem;
@property (nonatomic,strong) KSNavigationButtonItem *rightButtonItem;

/** 左右添加多个item */
@property (nonatomic,strong) NSArray <KSNavigationButtonItem *>*leftButtonItems;
@property (nonatomic,strong) NSArray <KSNavigationButtonItem *>*rightButtonItems;


- (void)addLeftButtonItem:(KSNavigationButtonItem *)buttonItem;
- (void)addRightButtonItem:(KSNavigationButtonItem *)buttonItem;
- (void)removeButtonItem:(KSNavigationButtonItem *)buttonItem;

- (void)insertLeftButtonItem:(KSNavigationButtonItem *)buttonItem atIndex:(NSUInteger)index;
- (void)removeLeftButtonItemAtIndex:(NSUInteger)index;
- (void)insertRightButtonItem:(KSNavigationButtonItem *)buttonItem atIndex:(NSUInteger)index;
- (void)removeRightButtonItemAtIndex:(NSUInteger)index;

- (UIButton *)buttonWithButtonItem:(KSNavigationButtonItem *)buttonItem;
- (UIButton *)leftButtonAtIndex:(NSUInteger)index;
- (UIButton *)rightButtonAtIndex:(NSUInteger)index;

@end
