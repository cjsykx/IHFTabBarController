# IHFTabBarController

IHFTabBarController 使用方法类似系统的TabBarController。
github地址：https://github.com/cjsykx/IHFTabBarController

主要为了这2个效果重写了这个控件：
效果1：TabBar可以滑动，意味着可以加入很多个可以选择的控制器。一般用系统的都是4-5个。
效果2：选择控制器的时候有动画效果。

****
使用方法
****
1.导入IHFTabBarController.h（通常在AppDelegate.h中）
2.创建TabBar controller，并设置其管理的控制器,代码如下

```
// nav1 - nav6 是Navagation controller 的对象
IHFTabBarController *tabBarVC = [[IHFTabBarController alloc] initWithViewControllers:@[nav1,nav2,nav3,nav4,nav5,nav6]];
tabBarVC.selectedIndex = 0;
```
例nav1,也创建了一个TabBarItem的Title,image和BadgeValue
```
ViewController *vc1 = [[ViewController alloc] init]; 
UINavigationController *nav1= [[UINavigationController alloc] initWithRootViewController:vc1];
vc1.view.backgroundColor = [UIColor blueColor];
vc1.tabBarItem.badgeValue = @"23";
vc1.title = @"基本信息";
vc1.tabBarItem.image = [UIImage imageNamed:@"Patient_tabBar_signsInput"]; 
vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"Patient_tabBar_signsInput"];
```
> IHFTabBarController 中的重要属性
1.selectedIndex ： 选择的控制器下标。默认是0 ，默认是一个，可以修改为你想默认选中的控制器。
2.viewControllers 子控制器。Readonly 属性,只能用初始化initWithViewControllers设置。

3.设置外观：
####使用IHFTabBar进行设置：####
例如：
```
tabBarVC.selectedIndex = 0;
tabBarVC.tabBar.tabBarBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
tabBarVC.tabBar.maskColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
```
重要属性介绍：
countVisible： 屏幕可见的TabBarItem个数，多出的要根据滑动才能选择，默认是4个。
itemTitleColor：未选中的Item字体颜色，默认黑色
selectedItemTitleColor :选中的Item字体颜色,默认红色
tabBarBackgroundColor：TabBar的背景颜色。
maskColor：遮罩层的颜色，默认白色
maskImage：遮罩层的图像
tabBarItemScaleAnimation：缩放动画，默认有。

简书地址：http://www.jianshu.com/p/b70620752c99