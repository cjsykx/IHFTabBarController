//
//  IHFTabBar.m
//  NurseV2
//
//  Created by chenjiasong on 16/8/18.
//  Copyright © 2016年 IHEFE CO., LIMITED. All rights reserved.
//


#import "IHFTabBar.h"
#import "IHFTabBarItem.h"
@interface IHFTabBar ()
@property (strong, nonatomic) NSArray *tabBarItems;
@property (strong, nonatomic) IHFTabBarItem *selectedItem;
@property (weak, nonatomic) UIImageView *maskView;
@property (assign, nonatomic) CGFloat itemWidth;

// Come from IHFTabBarController
// Uses Notification to get beacause it can't not be public property for user.
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray <UIViewController *> *viewControllers;

@end

@implementation IHFTabBar

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setUpdefaultParameters];
        [self addNotification];
    }
    return self;
}

- (void)setUpdefaultParameters {
    
    // Appearence set
    self.tabBarBackgroundColor = [UIColor lightGrayColor];
    self.itemTitleFont = [UIFont systemFontOfSize:11];
    self.badgeTitleFont = [UIFont systemFontOfSize:11];
    self.itemTitleColor = [UIColor blackColor];
    self.selectedItemTitleColor = [UIColor redColor];
    self.itemImageRatio = 0.6;
    self.maskColor = [UIColor colorWithWhite:1 alpha:0.5];
    // scroll view set
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    self.tabBarItemScaleAnimation = YES;
}


- (void)didClickTabBar:(UIButton *)sender {
    
    if (sender.tag == _selectedIndex) return;

    if ([self.tabBarDelegate respondsToSelector:@selector(tabBar:didSelectedTabBarItemFromIndex:toIndex:)]) {
        [self.tabBarDelegate tabBar:self didSelectedTabBarItemFromIndex:_selectedIndex toIndex:sender.tag];
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor {
    
    _itemTitleColor = itemTitleColor;
}

#pragma mark - mask view or color

- (void)addMaskView {
    
    UIImageView *maskView = [[UIImageView alloc] init];
    [self addSubview:maskView];
    [self bringSubviewToFront:maskView];
    maskView.userInteractionEnabled = NO;
    _maskView = maskView;
}

- (void)setMaskColor:(UIColor *)maskColor {
    if (_maskColor == maskColor) return;
    
    _maskColor = maskColor;
    self.maskView.backgroundColor = maskColor;
}

- (void)setMaskImage:(UIImage *)maskImage {
    if (_maskImage == maskImage) return;

    _maskImage = maskImage;
    self.maskView.image = maskImage;
}

- (void)setCountVisible:(NSInteger)countVisible {
    
    if (countVisible == _countVisible) return;
    
    _countVisible = countVisible;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.contentSize = CGSizeMake(screenWidth / (countVisible * 1.0) * self.tabBarItemCount, self.frame.size.height);
}

#pragma mark - mask view
- (void)moveMaskViewToIndex:(NSInteger)toIndex {
    CGRect frame = self.maskView.frame;
    frame.origin.x = toIndex * self.itemWidth;

    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.frame = frame;
    }];
    
    [self animationButton:[self.tabBarItems objectAtIndex:toIndex]];
}

- (UIImageView *)maskView {
    if(!_maskView) {
        [self addMaskView];
    }
    return _maskView;
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat Height = self.frame.size.height;
    CGFloat itemY = 0;
    CGFloat itemW = self.itemWidth;
    CGFloat itemH = Height;
    
    for (int i = 0; i < self.tabBarItemCount; i++) {
        IHFTabBarItem *tabBarItem = [self.tabBarItems objectAtIndex:i];
        CGFloat itemX = i * itemW;
        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }
    
    // add mask view frame
    CGFloat maskViewX = _selectedIndex * itemW;
    CGFloat maskViewY = 0;
    CGFloat maskViewW = itemW;
    CGFloat maskViewH = itemH;
    _maskView.frame = CGRectMake(maskViewX, maskViewY, maskViewW, maskViewH);
}

- (CGFloat)itemWidth {
    
    CGFloat Width = self.frame.size.width;
    NSInteger count = (self.countVisible > self.tabBarItemCount) ? self.tabBarItemCount : self.countVisible;
    return  Width / (count * 1.0);
}

#pragma mark - animation
-(void)animateToValue:(CGFloat)value forView:(UIView *)view duration:(CFTimeInterval)duration {
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.delegate = self;
    anima.keyPath = @"transform";
    anima.duration = duration;
    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(value, 0, 1)];
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:anima forKey:@"maskViewMove"];
}

- (void)animationButton:(UIButton *)button {
    
    if (!_tabBarItemScaleAnimation) return;
    
    UIImageView *view = button.imageView;
    UILabel *label = button.titleLabel;
    
    [UIView animateWithDuration:0.1 animations:^(void) {
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
         label.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
     } completion:^(BOOL finished){
         [UIView animateWithDuration:0.1 animations:^(void) {
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
             label.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
          } completion:^(BOOL finished) {
              [UIView animateWithDuration:0.1 animations:^(void) {
                  view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                  label.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
               } completion:^(BOOL finished){
               }];
          }];
     }];
}

#pragma mark - Notification 

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSelectedIndexWithNoti:) name:IHFTabBarSelectedIndexDidChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setViewControllersWithNoti:) name:IHFTabBarViewControllersDidSetNotification object:nil];
}

- (void)setSelectedIndexWithNoti:(NSNotification *)noti {
    
    NSInteger selectedIndex = 0;

    if ([noti.object isKindOfClass:[NSNumber class]]) {
        selectedIndex = [noti.object integerValue];
    }
    
    if (selectedIndex > [_viewControllers count] - 1) return;
    
    _selectedIndex = selectedIndex;
    
    [self moveMaskViewToIndex:selectedIndex];
    
    // Let Controller to selected it
    _selectedItem.selected = NO;
    _selectedItem = [self.tabBarItems objectAtIndex:selectedIndex];
    _selectedItem.selected = YES;
}

- (void)setViewControllersWithNoti:(NSNotification *)noti {
    
    NSArray *viewControllers;
    
    if ([noti.object isKindOfClass:[NSArray class]]) {
        viewControllers = noti.object;
    }
    
    __weak typeof(self) weakSelf = self;
    _viewControllers = viewControllers;
    _tabBarItemCount = [viewControllers count];
    
    self.countVisible = 4;
    
    __block NSMutableArray *tabBarItems = [NSMutableArray array];
    [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        IHFTabBarItem *item = [[IHFTabBarItem alloc] initWithTabBar:weakSelf];
        item.tabBarItem = obj.tabBarItem;
        item.tag = idx;
        [item addTarget:self action:@selector(didClickTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf addSubview:item];
        [tabBarItems addObject:item];
    }];
    
    // add mask view
    [self maskView];
    
    _tabBarItems = tabBarItems;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
