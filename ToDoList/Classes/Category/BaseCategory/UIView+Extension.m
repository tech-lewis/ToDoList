//
//  UIView+Extension.m
//
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年  All rights reserved.
//

#import "UIView+Extension.h"



static NSString *const KCBadgeValueLabelKey = @"kc_badgeValueLabel";
static NSString *const KCBorderLayerKey = @"kc_borderLayer";
static NSString *KCViewTapBlockKey = @"KCViewTapBlockKey";

static NSString *const KCActivityIndicatorViewKey = @"kc_activityIndicatorView";

@interface UIView()

@property (nonatomic, strong) UILabel *kc_badgeValueLabel;

@property (nonatomic,strong) UIActivityIndicatorView *kc_activityIndicatorView;

@end


@implementation UIView (Extension)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setMaxX:(CGFloat)maxX {
    self.x = maxX - self.width;
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    self.y = maxY - self.height;
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}


- (void)kc_showActivityIndicator
{
    [self.kc_activityIndicatorView startAnimating];
}

- (void)kc_hideActivityIndicator
{
    [self.kc_activityIndicatorView stopAnimating];
}

- (void)kc_setActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
    self.kc_activityIndicatorView.activityIndicatorViewStyle = style;
}


- (UIActivityIndicatorView *)kc_activityIndicatorView
{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, (__bridge const void *)(KCActivityIndicatorViewKey));
    
    if (!indicatorView) {
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.hidesWhenStopped = YES;
        [self addSubview:indicatorView];
        indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        objc_setAssociatedObject(self, (__bridge const void *)(KCActivityIndicatorViewKey), indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:indicatorView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:indicatorView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
    }
    
    return indicatorView;
}


/**********************/
#pragma mark -显示红点
- (void)setKc_badgeFont:(UIFont *)kc_badgeFont
{
    self.kc_badgeValueLabel.font = kc_badgeFont;
}

- (UIFont *)kc_badgeFont
{
    return self.kc_badgeValueLabel.font;
}

- (void)setKc_badgeColor:(UIColor *)kc_badgeColor
{
    self.kc_badgeValueLabel.textColor = kc_badgeColor;
    
}

- (UIColor *)kc_badgeColor
{
    return self.kc_badgeValueLabel.textColor;
}

- (void)setKc_badgeValue:(NSString *)kc_badgeValue
{
    
    
    if (kc_badgeValue) {
        self.kc_badgeValueLabel.hidden = NO;
        self.kc_badgeValueLabel.text = kc_badgeValue;
        if (kc_badgeValue.length) {
            
            
            CGSize textSize = [kc_badgeValue sizeWithAttributes:@{NSFontAttributeName : self.kc_badgeValueLabel.font}];
            CGFloat h = textSize.height + self.kc_badgeValueLabel.font.lineHeight * 0.4;
            CGFloat minW = h;
            CGFloat w = textSize.width + self.kc_badgeValueLabel.font.lineHeight * 0.8;
            
            w = w < minW ? minW : w;
            
            self.kc_badgeValueLabel.frame = CGRectMake(self.frame.size.width - w * 0.5, - h * 0.5, w, h);
            
            self.kc_badgeValueLabel.layer.cornerRadius = h * 0.5;
            
        }else {
            
            CGFloat wh = 8;
            self.kc_badgeValueLabel.frame = CGRectMake(self.frame.size.width - wh * 0.5, - wh * 0.5, wh, wh);
            
            self.kc_badgeValueLabel.layer.cornerRadius = wh * 0.5;
        }
    }else {
        self.kc_badgeValueLabel.hidden = YES;
    }
}

- (NSString *)kc_badgeValue
{
    return self.kc_badgeValueLabel.text;
}

- (void)setKc_badgeBackgroundColor:(UIColor *)kc_badgeBackgroundColor
{
    self.kc_badgeValueLabel.layer.backgroundColor = kc_badgeBackgroundColor.CGColor;
}

-(void)setKc_badgeBorderColor:(UIColor *)kc_badgeBorderColor{
    self.kc_badgeValueLabel.layer.borderWidth = 1;
    self.kc_badgeValueLabel.layer.borderColor = kc_badgeBorderColor.CGColor;
}

- (UIColor *)kc_badgeBackgroundColor
{
    return [UIColor colorWithCGColor:self.kc_badgeValueLabel.layer.backgroundColor];
}

- (void)kc_setBadgeValue:(NSString *)badgeValue offset:(CGPoint)offset
{
    self.kc_badgeValue = badgeValue;
    
    CGRect temp = self.kc_badgeValueLabel.frame;
    temp.origin.x = self.frame.size.width - temp.size.width * 0.5 + offset.x;
    temp.origin.y = - temp.size.height * 0.5 + offset.y;
    
    self.kc_badgeValueLabel.frame = temp;
}

- (UILabel *)kc_badgeValueLabel
{
    UILabel *badgeValueLabel = objc_getAssociatedObject(self, (__bridge const void *)(KCBadgeValueLabelKey));
    
    if (!badgeValueLabel) {
        badgeValueLabel = [[UILabel alloc] init];
        badgeValueLabel.font = [UIFont systemFontOfSize:10];
        badgeValueLabel.textColor = [UIColor whiteColor];
        badgeValueLabel.textAlignment = NSTextAlignmentCenter;
        badgeValueLabel.layer.backgroundColor = [UIColor redColor].CGColor;
        [self addSubview:badgeValueLabel];
        objc_setAssociatedObject(self, (__bridge const void *)(KCBadgeValueLabelKey), badgeValueLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return badgeValueLabel;
    
}


+(instancetype)viewWithXibs {
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


/******* *******/

- (void)setCycle {
    
    [self setCycle:4];
}

- (void)setCycle:(CGFloat)radus  {
    
    self.layer.cornerRadius = radus;
    self.clipsToBounds = YES;
}

-(void)setBorderWidth:(CGFloat)width borderColor:(UIColor *)color {
    
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end
