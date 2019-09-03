//
//  BaseTabbarVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "BaseTabbarVC.h"
#import "BaseNavVC.h"
#import "HomeVC.h"
#import "MeVC.h"
#import "TabbarControllerAnimation.h"

@interface BaseTabbarVC ()<UITabBarControllerDelegate>

@end

@implementation BaseTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    self.delegate = self;
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize imageSize = CGSizeMake(24, 24);
    
    UIImage *homeImage = [UITool createImageWithSize:imageSize text:@"😆" attriDict:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    HomeVC *homeVC = [[HomeVC alloc] init];
    homeVC.title = @"Home";
    homeVC.tabBarItem.image = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavVC *homeNav = [[BaseNavVC alloc] initWithRootViewController:homeVC];
    
    UIImage *meImage = [UITool createImageWithSize:imageSize text:@"😤" attriDict:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    MeVC *meVC = [[MeVC alloc] init];
    meVC.title = @"Me";
    meVC.tabBarItem.image = [meImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavVC *meNav = [[BaseNavVC alloc] initWithRootViewController:meVC];
    
    self.viewControllers = @[homeNav,meNav];
}

#pragma mark - UITabBarControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [[TabbarControllerAnimation alloc] init];
}

@end
