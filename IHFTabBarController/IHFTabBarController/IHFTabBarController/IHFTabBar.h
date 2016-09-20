//
//  IHFTabBar.h
//  NurseV2
//
//  Created by chenjiasong on 16/8/18.
//  Copyright © 2016年 IHEFE CO., LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>

// Notifacation
#define IHFTabBarSelectedIndexDidChangedNotification @"IHFTabBarSelectedIndexDidChangedNotification"
#define IHFTabBarViewControllersDidSetNotification @"IHFTabBarViewControllersDidSetNotification"

@class IHFTabBar;
@protocol IHFTabBarDelegate <NSObject>
@optional

- (void)tabBar:(IHFTabBar *)tabBar didSelectedTabBarItemFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

@end

@interface IHFTabBar : UIScrollView


@property (nonatomic, assign , readonly) NSInteger tabBarItemCount ;

@property (assign ,nonatomic) NSInteger countVisible; /**< Visible count , defalut is 4 */

// item title
@property (nonatomic, strong) UIColor *itemTitleColor; /**< Tab bar item title color */
@property (nonatomic, strong) UIColor *selectedItemTitleColor; /**< selected tab bar item title color */
@property (nonatomic, strong) UIFont *itemTitleFont; /**< Tab bar item title color */

// badge
@property (nonatomic, strong) UIFont *badgeTitleFont; /**< Tab bar badge title font */

@property (nonatomic, assign) CGFloat itemImageRatio; /**< Tab bar item image ratio  */

// background color
@property (nonatomic, assign) UIColor *tabBarBackgroundColor; /**< Tab bar item image ratio */

@property (nonatomic, weak) id <IHFTabBarDelegate> tabBarDelegate;

// mask view or color

@property (nonatomic, strong) UIColor *maskColor; /**< Mask color in your select tab bar item */
@property (nonatomic, strong) UIImage *maskImage; /**< Mask image in your select tab bar item */

@property (assign,nonatomic) BOOL tabBarItemScaleAnimation ; /**< Default YES , if you not need , set NO */
@end
