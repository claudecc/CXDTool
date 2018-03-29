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
    BaseVC *homeVC = [HomeVC new];
    homeVC.title = @"Home";
    BaseNavVC *homeNav = [[BaseNavVC alloc] initWithRootViewController:homeVC];
    
    BaseVC *meVC = [MeVC new];
    meVC.title = @"Me";
    BaseNavVC *meNav = [[BaseNavVC alloc] initWithRootViewController:meVC];
    
    self.viewControllers = @[homeNav,meNav];
}

@end
