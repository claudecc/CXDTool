//
//  NSObject+Router.m
//  CXDTool
//
//  Created by claudechoi on 2019/4/19.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import "NSObject+Router.h"

@implementation NSObject (Router)

- (UIViewController *)getCurrentVC {
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        else if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        else if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }
        else if ([vc isKindOfClass:[UISplitViewController class]])
        { // ipad
            vc = [[(UISplitViewController*)vc delegate] primaryViewControllerForExpandingSplitViewController:(UISplitViewController*)vc];
        }
        else {
            break;
        }
    }
    return vc;
}

@end
