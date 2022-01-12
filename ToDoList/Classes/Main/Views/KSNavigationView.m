//
//  KSNavigationView.m
//  KuShow
//
//  Created by iMac on 2017/6/6.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "KSNavigationView.h"
#import "Base_Define.h"

@implementation KSNavigationButtonItem

- (instancetype)init {
    if (self = [super init]) {
        
        self.enabled = YES;
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title handle:(void (^)(KSNavigationButtonItem *))handle {
    return [self initWithTitle:title image:nil highlightedImage:nil handle:handle];
}

+ (instancetype)itemWithTitle:(NSString *)title handle:(void (^)(KSNavigationButtonItem *))handle {
    return [[self alloc] initWithTitle:title handle:handle];
}

+(instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)color handle:(void (^)(KSNavigationButtonItem *))handle {
    KSNavigationButtonItem *item = [[self alloc]initWithTitle:title handle:handle];
    item.titleColor = color;
    return item;
}


+ (instancetype)itemWithImage:(UIImage *)image handle:(void(^)(KSNavigationButtonItem * item))handle {
    return [[self alloc] initWithImage:image handle:handle];
}

- (instancetype)initWithImage:(UIImage *)image handle:(void(^)(KSNavigationButtonItem * item))handle {
    return [self initWithImage:image highlightedImage:nil handle:handle];
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage handle:(void (^)(KSNavigationButtonItem *))handle {
    return [self initWithTitle:nil image:image highlightedImage:highlightedImage handle:handle];
}

+ (instancetype)itemWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage handle:(void (^)(KSNavigationButtonItem *))handle {
    
    return [[self alloc] initWithImage:image highlightedImage:highlightedImage handle:handle];
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage handle:(void(^)(KSNavigationButtonItem * item))handle {
    
    if (self = [self init]) {
        self.title = title;
        self.image = image;
        self.highlightedImage = highlightedImage;
        self.handle = handle;

    }
    return self;
}

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage handle:(void(^)(KSNavigationButtonItem * item))handle {
    return [[self alloc] initWithTitle:title image:image highlightedImage:highlightedImage handle:handle];
    
}

@end

@interface KSNavigationView ()

@property (nonatomic,strong) NSMutableArray *leftButtons;
@property (nonatomic,strong) NSMutableArray *rightButtons;


@end

@implementation KSNavigationView

- (void)dealloc {
    [self removeLeftButtonItemKVO];
    [self removeRightButtonItemKVO];
}

- (void)addLeftButtonItemKVO {
    for (KSNavigationButtonItem *buttonItem in self.leftButtonItems) {
        [self addButtonItemKVO:buttonItem];
    }

}
- (void)removeLeftButtonItemKVO {
    
    for (KSNavigationButtonItem *buttonItem in self.leftButtonItems) {
        [self removeButtonItemKVO:buttonItem];
    }
}

- (void)addRightButtonItemKVO {
    for (KSNavigationButtonItem *buttonItem in self.rightButtonItems) {
        [self addButtonItemKVO:buttonItem];
    }
    
}
- (void)removeRightButtonItemKVO {
    
    for (KSNavigationButtonItem *buttonItem in self.rightButtonItems) {
        [self removeButtonItemKVO:buttonItem];
    }
}

- (void)addButtonItemKVO:(KSNavigationButtonItem *)item {
    
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"highlightedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"disabledImage" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeButtonItemKVO:(KSNavigationButtonItem *)item {
    
    [item removeObserver:self forKeyPath:@"title"];
    [item removeObserver:self forKeyPath:@"image"];
    [item removeObserver:self forKeyPath:@"highlightedImage"];
    [item removeObserver:self forKeyPath:@"enabled"];
    [item removeObserver:self forKeyPath:@"disabledImage"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    UIButton *btn = nil;
    
    if ([self.leftButtonItems containsObject:object]) {
        
        NSInteger index = [self.leftButtonItems indexOfObject:object];
        
        btn = self.leftButtons[index];
        
    }else {
        
        NSInteger index = [self.rightButtonItems indexOfObject:object];
        
        btn = self.rightButtons[index];
    }
    
    KSNavigationButtonItem *buttonItem = object;
    
    if ([keyPath isEqualToString:@"title"]) {
        [btn setTitle:buttonItem.title forState:UIControlStateNormal];
    }else if ([keyPath isEqualToString:@"image"]) {
        [btn setImage:buttonItem.image forState:UIControlStateNormal];
    }else if ([keyPath isEqualToString:@"highlightedImage"]) {
        [btn setImage:buttonItem.highlightedImage forState:UIControlStateHighlighted];
    }else if ([keyPath isEqualToString:@"disabledImage"]) {
        [btn setImage:buttonItem.disabledImage forState:UIControlStateDisabled];
        
    }else if ([keyPath isEqualToString:@"enabled"]) {
        btn.enabled = buttonItem.isEnabled;
    }
    
}


#pragma mark -Setter
- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    _backgroundAlpha = backgroundAlpha;
    
    self.backgroundView.alpha = backgroundAlpha;
    self.shadowView.alpha = backgroundAlpha;
    self.statusBar.alpha = backgroundAlpha;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString *)attributedTitle {
    _attributedTitle = attributedTitle;
    
    self.titleLabel.attributedText = attributedTitle;
    [self setNeedsLayout];
}

- (void)setTitleView:(UIView *)titleView {
    [_titleView removeFromSuperview];
    _titleView = titleView;
    [self addSubview:titleView];
    [self setNeedsLayout];
}

- (UIButton *)buttonWithButtonItem:(KSNavigationButtonItem *)buttonItem index:(NSInteger)index action:(SEL)action {
    UIButton *btn = [UIButton new];
//    btn.backgroundColor = kRandonColor;
    [btn setTitle:buttonItem.title forState:UIControlStateNormal];
    [btn setImage:buttonItem.image forState:UIControlStateNormal];
    [btn setImageEdgeInsets:buttonItem.imageInsets];
    [btn setTitleEdgeInsets:buttonItem.titleInserts];
    [btn setImage:buttonItem.highlightedImage forState:UIControlStateHighlighted];
    [btn setImage:buttonItem.disabledImage forState:UIControlStateDisabled];
    btn.titleLabel.font = AdaptedFontSize(14);
    btn.enabled = buttonItem.isEnabled;
    btn.tag = index;
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setImage:buttonItem.disabledImage forState:UIControlStateDisabled];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
//    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    if (buttonItem.titleColor) {
        [btn setTitleColor:buttonItem.titleColor forState:UIControlStateNormal];
    }

    [self addSubview:btn];
    
//    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    /**/
    [self addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.statusBar attribute:NSLayoutAttributeBottom multiplier:1 constant:4]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-4]];
    
//    CGFloat btnW = btn.frame.size.width > 44 ? btn.frame.size.width : 44;
    /*
    [self addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:10]];
    [btn addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:0 toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];*/
                           
    [btn addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:btn attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    return btn;
}

- (void)setupLeftButtons {
    [self.leftButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.leftButtons removeAllObjects];
    
    UIButton *leftPreviousBtn = nil;
    for (int i = 0; i < self.leftButtonItems.count; i++) {
        
        UIButton *btn = [self buttonWithButtonItem:self.leftButtonItems[i] index:i action:@selector(leftBtnClick:)];
        
        [self.leftButtons addObject:btn];
        
        if (leftPreviousBtn) {
            
            [self addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftPreviousBtn attribute:NSLayoutAttributeRight multiplier:1 constant:self.itemSpacing]];
        }else {
            
            [self addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.itemInset]];
        }
        leftPreviousBtn = btn;
    }
}

- (void)setupRightButtons {
    [self.rightButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.rightButtons removeAllObjects];
    
    UIButton *rightPreviousBtn = nil;
    for (int i = 0; i < self.rightButtonItems.count; i++) {
        UIButton *btn = [self buttonWithButtonItem:self.rightButtonItems[i] index:i action:@selector(rightBtnClick:)];
        [self.rightButtons addObject:btn];
                if (rightPreviousBtn) {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightPreviousBtn attribute:NSLayoutAttributeLeft multiplier:1 constant:-self.itemSpacing]];
        }else {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-self.itemInset]];
        }
        
        rightPreviousBtn = btn;
        
    }

}

#pragma mark -Setter
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.backgroundView.image = backgroundImage;
}

- (void)setStatusBarImage:(UIImage *)statusBarImage {
    _statusBarImage = statusBarImage;
    
    self.statusBar.image = statusBarImage;
}


- (void)setShadowImage:(UIImage *)shadowImage {
    _shadowImage = shadowImage;
    
    self.shadowView.image = shadowImage;
}

- (void)setLeftButtonItems:(NSArray<KSNavigationButtonItem *> *)leftButtonItems {
    [self removeLeftButtonItemKVO];
    _leftButtonItems = leftButtonItems;
    [self addLeftButtonItemKVO];
    
    [self setupLeftButtons];
}

- (void)setLeftButtonItem:(KSNavigationButtonItem *)leftButtonItem {
    
    NSArray *leftButtonItems = self.leftButtonItems;
    
    if (leftButtonItems.count) {
        
        NSMutableArray *tmp = leftButtonItems.mutableCopy;
        [tmp replaceObjectAtIndex:0 withObject:leftButtonItem];
        leftButtonItems = tmp;
        
    }else {
        leftButtonItems = @[leftButtonItem];
        
    }
    
    self.leftButtonItems = leftButtonItems;
    
}

- (KSNavigationButtonItem *)leftButtonItem {
    return self.leftButtonItems.firstObject;
}

- (void)setRightButtonItems:(NSArray<KSNavigationButtonItem *> *)rightButtonItems {
    
    [self removeRightButtonItemKVO];
    _rightButtonItems = rightButtonItems;
    [self addRightButtonItemKVO];
    
    [self setupRightButtons];
}

- (void)setRightButtonItem:(KSNavigationButtonItem *)rightButtonItem {
    
    NSArray *rightButtonItems = self.rightButtonItems;
    
    if (rightButtonItems.count) {
        
        NSMutableArray *tmp = rightButtonItems.mutableCopy;
        [tmp replaceObjectAtIndex:0 withObject:rightButtonItem];
        rightButtonItems = tmp;
        
    }else {
        rightButtonItems = @[rightButtonItem];
    }
    
    self.rightButtonItems = rightButtonItems;
    
}

- (KSNavigationButtonItem *)rightButtonItem {
    return self.rightButtonItems.firstObject;
}

#pragma mark -Getter

- (UIImageView *)statusBar {
    if (!_statusBar) {
        _statusBar = [UIImageView new];
        _statusBar.backgroundColor = [UIColor clearColor];
    }
    return _statusBar;
}

- (NSMutableArray *)leftButtons {
    if (!_leftButtons) {
        _leftButtons = @[].mutableCopy;
    }
    return _leftButtons;
}

- (NSMutableArray *)rightButtons {
    if (!_rightButtons) {
        _rightButtons = @[].mutableCopy;
    }
    return _rightButtons;
}

- (UIImageView *)shadowView {
    if (!_shadowView) {
        _shadowView = [UIImageView new];
        
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context  = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0 alpha:0.1].CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _shadowView.hidden = YES;
        _shadowView.image = img;
    }
    return _shadowView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIImageView new];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.98];
//        _backgroundView.backgroundColor = [UIColor redColor];
    }
    return _backgroundView;
}

#pragma mark -Event
- (void)leftBtnClick:(UIButton *)btn {
    KSNavigationButtonItem *buttonItem = self.leftButtonItems[btn.tag];
    
    !buttonItem.handle ? : buttonItem.handle(buttonItem);
    
}

- (void)rightBtnClick:(UIButton *)btn {
    KSNavigationButtonItem *buttonItem = self.rightButtonItems[btn.tag];
    
    !buttonItem.handle ? : buttonItem.handle(buttonItem);
    
}


#pragma mark -Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _itemSpacing = 5;
        _itemInset = 5;
        [self setupUI];
        [self setupLayout];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIButton *leftLastBtn = self.leftButtons.lastObject;
    UIButton *rightLastBtn = self.rightButtons.lastObject;
    
    CGFloat startX = 0;
    
    if (leftLastBtn) {
        startX = leftLastBtn.frame.size.width + leftLastBtn.frame.origin.x + self.itemSpacing;
    }else {
        startX += self.itemInset;
    }
    
    CGFloat endX = self.bounds.size.width;
    if (rightLastBtn) {
        endX = rightLastBtn.frame.origin.x - self.itemSpacing;
    }else {
        
        endX -= self.itemInset;
    }
    
    CGFloat maxWidth = endX - startX;
    
    [self.titleLabel sizeToFit];
    
    CGFloat statusBarHeight = self.statusBar.frame.size.height;
    if (self.titleLabel.frame.size.width > maxWidth) {
        
        CGRect titleLabelFrame = self.titleLabel.frame;
        titleLabelFrame.origin.x = startX;
        titleLabelFrame.size.width = maxWidth;
        self.titleLabel.frame = titleLabelFrame;
        
        
        CGPoint titleLabelCenter = self.titleLabel.center;
        titleLabelCenter.y = self.frame.size.height * 0.5 + statusBarHeight * 0.5;
        self.titleLabel.center = titleLabelCenter;
        
    }else {
        
        self.titleLabel.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5 + statusBarHeight * 0.5);
    }
    
    
    if (!self.titleView) {
        
        return;
        
    }
    
    if (self.titleView.frame.size.width > maxWidth) {
        
        CGRect titleViewFrame = self.titleView.frame;
        titleViewFrame.origin.x = startX;
        titleViewFrame.size.width = maxWidth;
        self.titleView.frame = titleViewFrame;
        
        CGPoint titleViewCenter = self.titleView.center;
        titleViewCenter.y = self.frame.size.height * 0.5 + statusBarHeight * 0.5;
        self.titleView.center = titleViewCenter;
        
    }else {
        
        self.titleView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5 + statusBarHeight * 0.5);
    }
    
    
}

#pragma mark -Private Method
- (void)setupUI {
     
    [self addSubview:self.backgroundView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.shadowView];
    [self addSubview:self.statusBar];
}

- (void)setupLayout {
    
    self.statusBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self.statusBar addConstraint:[NSLayoutConstraint constraintWithItem:self.statusBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[UIApplication sharedApplication].statusBarFrame.size.height]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.statusBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    /**** bgView约束 *****/
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    /**** shadowView约束 *****/
    self.shadowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.shadowView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.shadowView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.shadowView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self.shadowView addConstraint:[NSLayoutConstraint constraintWithItem:self.shadowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0.5]];
    
    
}

#pragma mark -Public Method
- (void)addLeftButtonItem:(KSNavigationButtonItem *)buttonItem {
    NSMutableArray *leftButtonItems = self.leftButtonItems.mutableCopy;
    
    if (leftButtonItems) {
        [leftButtonItems addObject:buttonItem];
    }else {
        leftButtonItems = @[buttonItem].mutableCopy;
    }
    
    self.leftButtonItems = leftButtonItems;
}


- (void)addRightButtonItem:(KSNavigationButtonItem *)buttonItem {
    
    NSMutableArray *rightButtonItems = self.rightButtonItems.mutableCopy;
    
    if (rightButtonItems) {
        [rightButtonItems addObject:buttonItem];
    }else {
        rightButtonItems = @[buttonItem].mutableCopy;
    }
    
    self.rightButtonItems = rightButtonItems;
}

-(void)removeButtonItem:(KSNavigationButtonItem *)buttonItem {
    if ([self.leftButtonItems containsObject:buttonItem]) {
        
        NSMutableArray *leftButtonItems = self.leftButtonItems.mutableCopy;
        
        [leftButtonItems removeObject:buttonItem];
        
        self.leftButtonItems = leftButtonItems;
        
    }else if ([self.rightButtonItems containsObject:buttonItem]) {
        
        NSMutableArray *rightButtonItems = self.rightButtonItems.mutableCopy;
        
        [rightButtonItems removeObject:buttonItem];
        
        self.rightButtonItems = rightButtonItems;
    }
}

- (void)insertLeftButtonItem:(KSNavigationButtonItem *)buttonItem atIndex:(NSUInteger)index {
    
    NSMutableArray *leftButtonItems = self.leftButtonItems.mutableCopy;
    
    if (leftButtonItems) {
        [leftButtonItems insertObject:buttonItem atIndex:index];
    }else {
        leftButtonItems = @[buttonItem].mutableCopy;
    }
    
    self.leftButtonItems = leftButtonItems;
    
    
}

- (void)removeLeftButtonItemAtIndex:(NSUInteger)index {
    
    if (self.leftButtonItems.count > index) {
        
        NSMutableArray *leftButtonItems = self.leftButtonItems.mutableCopy;
        [leftButtonItems removeObjectAtIndex:index];
        self.leftButtonItems = leftButtonItems;
        
    }
    
}

- (void)insertRightButtonItem:(KSNavigationButtonItem *)buttonItem atIndex:(NSUInteger)index {
    
    NSMutableArray *rightButtonItems = self.rightButtonItems.mutableCopy;
    
    if (rightButtonItems) {
        [rightButtonItems insertObject:buttonItem atIndex:index];
    }else {
        rightButtonItems = @[buttonItem].mutableCopy;
    }
    
    self.rightButtonItems = rightButtonItems;
}

- (void)removeRightButtonItemAtIndex:(NSUInteger)index {
    if (self.rightButtonItems.count > index) {
        
        NSMutableArray *rightButtonItems = self.rightButtonItems.mutableCopy;
        [rightButtonItems removeObjectAtIndex:index];
        self.rightButtonItems = rightButtonItems;
        
    }
}

- (UIButton *)buttonWithButtonItem:(KSNavigationButtonItem *)buttonItem {
    if ([self.leftButtonItems containsObject:buttonItem]) {
        
        return self.leftButtons[[self.leftButtonItems indexOfObject:buttonItem]];
    }else if ([self.rightButtonItems containsObject:buttonItem]) {
        return self.rightButtons[[self.rightButtonItems indexOfObject:buttonItem]];
    }
    return nil;
}

- (UIButton *)leftButtonAtIndex:(NSUInteger)index {
    if (self.leftButtons.count > index) {
        return self.leftButtons[index];
    }
    return nil;
}

- (UIButton *)rightButtonAtIndex:(NSUInteger)index {
    
    if (self.rightButtons.count > index) {
        return self.rightButtons[index];
    }
    return nil;
}



@end
