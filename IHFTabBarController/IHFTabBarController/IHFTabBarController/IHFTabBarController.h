//
//  IHFTabBarController.h
//  NurseV2
//
//  Created by chenjiasong on 16/8/18.
//  Copyright © 2016年 IHEFE CO., LIMITED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IHFTabBar.h"



@interface IHFTabBarController : UIViewController

@property (strong, nonatomic) IHFTabBar *tabBar;
@property (strong, nonatomic ,readonly) NSArray <UIViewController *> *viewControllers;

@property (nonatomic, assign) NSInteger selectedIndex; /**< selected index  */

- (instancetype)initWithViewControllers:(NSArray <UIViewController *> *)viewControllers;
@end
