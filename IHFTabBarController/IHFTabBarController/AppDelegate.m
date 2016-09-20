//
//  AppDelegate.m
//  IHFTabBarController
//
//  Created by chenjiasong on 16/9/20.
//  Copyright © 2016年 Cjson. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "IHFTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    ViewController *vc1 = [[ViewController alloc] init];
    UINavigationController *nav1= [[UINavigationController alloc] initWithRootViewController:vc1];
    
    vc1.view.backgroundColor = [UIColor blueColor];
    vc1.tabBarItem.badgeValue = @"23";
    vc1.title = @"基本信息";
    vc1.tabBarItem.image = [UIImage imageNamed:@"Patient_tabBar_signsInput"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"Patient_tabBar_signsInput"];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    UINavigationController *nav2= [[UINavigationController alloc] initWithRootViewController:vc2];
    
    vc2.view.backgroundColor = [UIColor greenColor];
    vc2.tabBarItem.badgeValue = @"1";
    vc2.title = @"遗嘱执行";
    vc2.tabBarItem.image = [UIImage imageNamed:@"Patient_tabBar_orderExecute"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"Patient_tabBar_orderExecute"];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    UINavigationController *nav3= [[UINavigationController alloc] initWithRootViewController:vc3];
    
    vc3.view.backgroundColor = [UIColor redColor];
    vc3.title = @"评估";
    vc3.tabBarItem.image = [UIImage imageNamed:@"Patient_tabBar_assessRecord"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"Patient_tabBar_assessRecord"];
    
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    UINavigationController *nav4= [[UINavigationController alloc] initWithRootViewController:vc4];
    
    vc4.view.backgroundColor = [UIColor yellowColor];
    vc4.tabBarItem.badgeValue = @"99+";
    vc4.title = @"其他";
    vc4.tabBarItem.image = [UIImage imageNamed:@"Patient_tabBar_signsInput"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"Patient_tabBar_orderExecute"];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    UINavigationController *nav5= [[UINavigationController alloc] initWithRootViewController:vc5];
    
    vc5.view.backgroundColor = [UIColor yellowColor];
    vc5.tabBarItem.badgeValue = @"";
    vc5.title = @"其他";
    vc5.tabBarItem.image = [UIImage imageNamed:@"Patient_tabBar_signsInput"];
    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"Patient_tabBar_orderExecute"];
    
    UIViewController *vc6 = [[UIViewController alloc] init];
    UINavigationController *nav6= [[UINavigationController alloc] initWithRootViewController:vc6];
    
    vc6.view.backgroundColor = [UIColor yellowColor];
    vc6.tabBarItem.badgeValue = @"99+";
    vc6.title = @"其他";
    vc6.tabBarItem.image = [UIImage imageNamed:@"Patient_tabBar_signsInput"];
    vc6.tabBarItem.selectedImage = [UIImage imageNamed:@"Patient_tabBar_orderExecute"];
    
    IHFTabBarController *tabBarVC = [[IHFTabBarController alloc] initWithViewControllers:@[nav1,nav2,nav3,nav4,nav5,nav6]];
    tabBarVC.selectedIndex = 0;
    //    tabBar.tabBar.countVisible = 5;
    //    tabBar.customTabBar.itemTitleColor = RGB(36, 222, 200);
    //    tabBar.customTabBar.selectedItemTitleColor = RGB(0, 0, 0);
    tabBarVC.tabBar.tabBarBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    //    tabBarVC.tabBar.maskColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    
    //    self.window.rootViewController
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    [_window setRootViewController:tabBarVC];
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
