//
//  IHFTabBarItem.m
//  NurseV2
//
//  Created by chenjiasong on 16/8/18.
//  Copyright © 2016年 IHEFE CO., LIMITED. All rights reserved.
//
#import "IHFTabBarItem.h"
#import "IHFTabBarBadge.h"

@interface IHFTabBarItem ()
@property (nonatomic, strong) IHFTabBarBadge *tabBarBadge;
@end

@implementation IHFTabBarItem

- (instancetype)initWithTabBar:(IHFTabBar *)tabBar {
    self = [super init];
    
    if (self) {
        [self setAppearenceWithTabBar:tabBar];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.tabBarBadge = [[IHFTabBarBadge alloc] initWithTabBar:self.tabBar];
        [self addSubview:self.tabBarBadge];

    }
    return self;
}

- (void)setAppearenceWithTabBar:(IHFTabBar *)tabBar {
    
    _tabBar = tabBar;

    [self setBackgroundColor:tabBar.tabBarBackgroundColor];
    [self setTitleColor:tabBar.itemTitleColor forState:UIControlStateNormal];
    [self setTitleColor:tabBar.selectedItemTitleColor forState:UIControlStateSelected];
    self.titleLabel.font = tabBar.itemTitleFont;
    
    [self addObserverForTabBar:tabBar];
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    
    _tabBarItem = tabBarItem;
    
    [self addObserverForTabBarItem:tabBarItem];
    
    [self setTitle:_tabBarItem.title forState:UIControlStateNormal];
    [self setImage:_tabBarItem.image forState:UIControlStateNormal];
    [self setImage:_tabBarItem.selectedImage forState:UIControlStateSelected];
    self.tabBarBadge.tabBarItem = _tabBarItem;

}

#pragma mark - add observer
- (void)addObserverForTabBarItem:(UITabBarItem *)tabBarItem {
    
    [tabBarItem addObserver:self forKeyPath:@"title" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"image" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
}

- (void)addObserverForTabBar:(IHFTabBar *)tabBar {
    
    [tabBar addObserver:self forKeyPath:@"tabBarBackgroundColor" options:0 context:nil];
    [tabBar addObserver:self forKeyPath:@"itemTitleColor" options:0 context:nil];
    [tabBar addObserver:self forKeyPath:@"selectedItemTitleColor" options:0 context:nil];
    [tabBar addObserver:self forKeyPath:@"itemTitleFont" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == _tabBarItem) {
        if ([keyPath isEqualToString:@"title"]) {
            [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
        } else if ([keyPath isEqualToString:@"image"]) {
            [self setImage:_tabBarItem.image forState:UIControlStateNormal];
        } else if ([keyPath isEqualToString:@"selectedImage"])
            [self setImage:_tabBarItem.selectedImage forState:UIControlStateSelected];
    }else if (object == _tabBar){
        if ([keyPath isEqualToString:@"tabBarBackgroundColor"]) {
            [self setBackgroundColor:_tabBar.tabBarBackgroundColor];
        } else if ([keyPath isEqualToString:@"itemTitleColor"]) {
            [self setTitleColor:_tabBar.itemTitleColor forState:UIControlStateNormal];
        } else if ([keyPath isEqualToString:@"selectedItemTitleColor"]) {
            [self setTitleColor:_tabBar.selectedItemTitleColor forState:UIControlStateSelected];
        } else if ([keyPath isEqualToString:@"itemTitleFont"]) {
            self.titleLabel.font = _tabBar.itemTitleFont;
        }
    }
}

- (void)dealloc{
    
    [self.tabBarItem removeObserver:self forKeyPath:@"title"];
    [self.tabBarItem removeObserver:self forKeyPath:@"image"];
    [self.tabBarItem removeObserver:self forKeyPath:@"selectedImage"];

    [self.tabBar removeObserver:self forKeyPath:@"tabBarBackgroundColor"];
    [self.tabBar removeObserver:self forKeyPath:@"itemTitleColor"];
    [self.tabBar removeObserver:self forKeyPath:@"selectedItemTitleColor"];
    [self.tabBar removeObserver:self forKeyPath:@"itemTitleFont"];
}

#pragma mark - reset TabBarItem content

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat imageX = 0.f;
    CGFloat imageY = 0.f;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * _tabBar.itemImageRatio;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat titleX = 0.f;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleY = contentRect.size.height * _tabBar.itemImageRatio + (_tabBar.itemImageRatio == 1.0f ? 100.0f : -5.0f);
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
