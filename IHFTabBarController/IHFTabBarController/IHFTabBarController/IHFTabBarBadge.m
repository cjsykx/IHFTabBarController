//
//  IHFTabBarBadge.m
//  NurseV2
//
//  Created by chenjiasong on 16/8/18.
//  Copyright © 2016年 IHEFE CO., LIMITED. All rights reserved.
//

#import "IHFTabBarBadge.h"

@implementation IHFTabBarBadge

#pragma mark - system method
- (instancetype)initWithTabBar:(IHFTabBar *)tabBar {
    self = [super init];
    
    if (self) {
        [self setAppearenceWithTabBar:tabBar];
        [self defaultSet];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_badgeValue && _badgeValue.length) {
        
        CGRect frame = self.frame;
        
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
            
        CGSize titleSize = [_badgeValue sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font, NSFontAttributeName, nil]];
        frame.size.width = MAX(badgeW, titleSize.width + 10);
        frame.size.height = badgeH;
        
        CGFloat marigin = 2.f;
        frame.origin.x = self.superview.frame.size.width - marigin - frame.size.width;
        frame.origin.y = marigin;
        self.frame = frame;
    }
}

#pragma mark - custom method
- (void)defaultSet {
    
    self.userInteractionEnabled = NO;
    self.hidden = YES;
    
//    UIImage *circleImage = [self imageForEllipseWithImageSize:CGSizeMake(44, 44) size:CGSizeMake(44, 44) offset:CGPointZero rotate:0.f backgroundColor:[UIColor clearColor] fillColor:[UIColor redColor] shadowColor:[UIColor clearColor] shadowOffset:CGPointZero shadowBlur:1.f];
//    
//    [self setBackgroundImage:[self resizedImageFromMiddle:circleImage]
//                    forState:UIControlStateNormal];

    [self setBackgroundImage:[self resizedImageFromMiddle:[UIImage imageNamed:@"IHFTabBarBadge"]]
                    forState:UIControlStateNormal];

}

- (void)setAppearenceWithTabBar:(IHFTabBar *)tabBar {
    
    _tabBar = tabBar;
    self.titleLabel.font = tabBar.badgeTitleFont;
    [self addObserverForTabBar:tabBar];
}

- (void)setBadgeValue:(NSString *)badgeValue {
    
    _badgeValue = badgeValue;
    
    if (badgeValue && badgeValue.length) {
        
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        [self setNeedsLayout];
    }else {
        self.hidden = YES;
    }
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    
    _tabBarItem = tabBarItem;
    
    self.badgeValue = tabBarItem.badgeValue;
    [self addObserverForTabBarItem:tabBarItem];
}


#pragma mark - add observer
- (void)addObserverForTabBarItem:(UITabBarItem *)tabBarItem {
    
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
}

- (void)addObserverForTabBar:(IHFTabBar *)tabBar{
    [tabBar addObserver:self forKeyPath:@"badgeTitleFont" options:0 context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object == _tabBarItem) {
        if ([keyPath isEqualToString:@"badgeValue"]) {
            self.badgeValue = _tabBarItem.badgeValue;
        }
    }else if (object == _tabBar) {
        if ([keyPath isEqualToString:@"badgeTitleFont"]) {
            self.titleLabel.font = _tabBar.badgeTitleFont;
        }
    }
}

- (void)dealloc {
    
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.tabBar removeObserver:self forKeyPath:@"badgeTitleFont"];
}


#pragma mark - support tool
- (UIImage *)resizedImageFromMiddle:(UIImage *)image {
    
    return [self resizedImage:image width:0.5f height:0.5f];
}

- (UIImage *)resizedImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height {
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * width
                                      topCapHeight:image.size.height * height];
}


#pragma mark - Ellipse

- (UIImage *)imageForEllipseWithImageSize:(CGSize)imageSize
                                 size:(CGSize)size
                               offset:(CGPoint)offset
                               rotate:(CGFloat)degrees
                      backgroundColor:(UIColor *)backgroundColor
                            fillColor:(UIColor *)fillColor
                          shadowColor:(UIColor *)shadowColor
                         shadowOffset:(CGPoint)shadowOffset
                           shadowBlur:(CGFloat)shadowBlur
{
    CGRect imageRect = CGRectMake(0.f, 0.f, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    BOOL backgroundNeeded = (backgroundColor && ![backgroundColor isEqual:[UIColor clearColor]]);
    BOOL fillNeeded = (fillColor && ![fillColor isEqual:[UIColor clearColor]]);
    BOOL shadowNeeded = (shadowColor && ![shadowColor isEqual:[UIColor clearColor]]);
    
    // BACKGROUND -----
    
    if (backgroundNeeded)
    {
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, imageRect);
    }
    
    // FILL -----
    
    if (fillNeeded)
    {
        if (shadowNeeded)
            CGContextSetShadowWithColor(context, CGSizeMake(shadowOffset.x, shadowOffset.y), shadowBlur, shadowColor.CGColor);
        
        // -----
        
        CGRect rect = CGRectMake(imageSize.width/2-size.width/2+offset.x, imageSize.height/2-size.height/2+offset.y, size.width, size.height);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        // -----
        
        if (degrees)
        {
            CGRect originalBounds = path.bounds;
            
            CGAffineTransform rotate = CGAffineTransformIdentity;
            [path applyTransform:rotate];
            
            CGAffineTransform translate = CGAffineTransformMakeTranslation(-(path.bounds.origin.x-originalBounds.origin.x)-(path.bounds.size.width-originalBounds.size.width)*0.5,
                                                                           -(path.bounds.origin.y-originalBounds.origin.y)-(path.bounds.size.height-originalBounds.size.height)*0.5);
            [path applyTransform:translate];
        }
        
        // -----
        
        [fillColor setFill];
        [path fill];
    }
    
    // MAKE UIImage -----
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
