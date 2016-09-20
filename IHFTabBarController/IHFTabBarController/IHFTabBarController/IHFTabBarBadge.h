//
//  IHFTabBarBadge.h
//  NurseV2
//
//  Created by chenjiasong on 16/8/18.
//  Copyright © 2016年 IHEFE CO., LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IHFTabBar.h"
@interface IHFTabBarBadge : UIButton
@property (nonatomic, strong) UITabBarItem *tabBarItem;
@property (nonatomic, strong ,readonly) IHFTabBar *tabBar;

- (instancetype)initWithTabBar:(IHFTabBar *)tabBar;

@property (nonatomic, copy) NSString *badgeValue;

@end
