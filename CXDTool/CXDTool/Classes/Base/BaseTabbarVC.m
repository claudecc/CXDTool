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

@interface BaseTabbarVC ()

@end

@implementation BaseTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    CGSize imageSize = CGSizeMake(24, 24);
    
    UIImage *homeImage = [UITool createImageWithSize:imageSize text:@"😆" attriDict:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    BaseVC *homeVC = [HomeVC new];
    homeVC.title = @"Home";
    homeVC.tabBarItem.image = [homeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavVC *homeNav = [[BaseNavVC alloc] initWithRootViewController:homeVC];
    
    UIImage *meImage = [UITool createImageWithSize:imageSize text:@"😤" attriDict:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    BaseVC *meVC = [MeVC new];
    meVC.title = @"Me";
    meVC.tabBarItem.image = [meImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BaseNavVC *meNav = [[BaseNavVC alloc] initWithRootViewController:meVC];
    
    self.viewControllers = @[homeNav,meNav];
}

@end
