//
//  NavigationView.m
//  ToDoList
//
//  Created by MarkLwis on 2022/1/27.
//  Copyright © 2022 TechLewis. All rights reserved.
//

#import "NavigationView.h"
#import "Masonry.h"
@interface NavigationView()
@property (nonatomic, strong) UILabel *titleContainer;
@property (nonatomic, strong) UIImageView *backgroundView;
/// 导航栏内容基础高度
@property (nonatomic, assign) CGFloat navigationBaseHeight;
@property (nonatomic, assign) CGFloat statusBarHeight;
@property (nonatomic, assign) CGFloat screenWidth;
/// 内容视图，承载左右两侧的操作按钮
@property (nonatomic, strong) UIToolbar *contentView;
/// 左侧操作集
@property (nonatomic, strong) NSMutableArray*leftItems;
/// 右侧操作集
@property (nonatomic, strong) NSMutableArray*rightItems;
@end

@implementation NavigationView
+ (UIFont *)defaultTitleFont;
{
  return [UIFont boldSystemFontOfSize:18.0];
}
/// 默认导航栏标题颜色
+ (UIColor *)defaultTitleColor
{
  return [UIColor blackColor];
}
/// 默认导航栏背景色
+ (UIColor *)defaultBackgroundColor
{
  return [UIColor whiteColor];
}
/// 默认导航栏背景图，接受图片名String，图片UIImage
+ (UIImage *)defaultBackgroundImage
{
  return nil;
}
/// 默认导航栏返回按钮图片名
+ (NSString *)defaultBackImage
{
  return nil;
}
/// 默认导航栏返回按钮标题
+ (NSString *)defaultBackTitle
{
  return @"返回";
}
/// 导航栏标题
- (UILabel *)titleLabel
{
  if (self.titleContainer == nil)
  {
    self.titleContainer = [[UILabel alloc] init];
  }
  return self.titleContainer;
}

/// 导航栏背景
- (UIImageView *)backgroundView
{
  if (_backgroundView == nil)
  {
    _backgroundView = [[UIImageView alloc] init];
  }
  
  return _backgroundView;
}
/// 左侧操作集
- (NSMutableArray *)leftItems
{
  if (_leftItems) {
    _leftItems = [NSMutableArray array];
  }
  
  return _leftItems;
}
/// 右侧操作集
- (NSMutableArray *)rightItems
{
  if (_rightItems) {
    _rightItems = [NSMutableArray array];
  }
  
  return _rightItems;

}

- (UIToolbar *)contentView
{
  if (_contentView) {
    _contentView = [[UIToolbar alloc] init];
  }
  
  return _contentView;
}
- (CGFloat)navigationBaseHeight
{
  return 44.0;
}
/// 状态栏高度
- (CGFloat)statusBarHeight
{
  return [[UIApplication sharedApplication] statusBarFrame].size.height;
}
/// 屏幕宽度
- (CGFloat)screenWidth
{
  return [UIScreen mainScreen].bounds.size.width;
}

/// 初始化
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, [self screenWidth], [self statusBarHeight] + self.navigationBaseHeight);
    
    
    // background
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundView.clipsToBounds = true;
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self);
    }];
    
    // content view
    self.contentView.frame = CGRectMake(0, [self statusBarHeight], self.screenWidth, 44.0);
    [self.contentView setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.contentView setShadowImage:[UIImage new] forToolbarPosition:UIBarPositionAny];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.contentView];
    
    // titleView
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleContainer];
    [self.titleContainer mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(self.contentView);
      make.leading.equalTo(self.contentView).mas_offset(40.0);
      make.trailing.equalTo(self.contentView).mas_offset(-40.0);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveStatusDidChange:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
  }
  return self;
}
- (void)updateBackgroundWithImage:(id)name color:(UIColor *)c
{
  self.backgroundView.backgroundColor = c;
  
  if ([name isKindOfClass:[NSString class]]) {
    self.backgroundView.image = [UIImage imageNamed:name];
  }
  else if ([name isKindOfClass:[UIImage class]]) {
    self.backgroundView.image = name;
  }
  else
  {
    self.backgroundView.image = nil;
  }
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  CGFloat width = self.superview.frame.size.width ? self.superview.frame.size.width : 0;
  CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
  self.frame = CGRectMake(0, 0, width, self.navigationBaseHeight + statusBarHeight);
  self.contentView.frame = CGRectMake(0, statusBarHeight, width, 44.0);
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action
- (void)recieveStatusDidChange:(NSNotification *)notification
{
  [self setNeedsLayout];
}
@end
