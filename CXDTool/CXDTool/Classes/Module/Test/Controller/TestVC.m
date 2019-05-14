//
//  TestVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/8/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "TestVC.h"
#import "PictureBrowserHeader.h"

@interface TestVC ()<UIGestureRecognizerDelegate>

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 图片展示
//    UIView *bgView = [[UIView alloc] init];
//    [self.view addSubview:bgView];
//    bgView.backgroundColor = UIColor.orangeColor;
//
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.centerY.equalTo(self.view);
//    }];
    
//    PictureDisplayView *pictureDisplayView = [[PictureDisplayView alloc] init];
//    [bgView addSubview:pictureDisplayView];
//    pictureDisplayView.backgroundColor = UIColor.lightGrayColor;
//
//    [pictureDisplayView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(bgView).offset(30);
//        make.left.equalTo(bgView).offset(60);
//        make.right.equalTo(bgView).offset(-60);
//        make.bottom.equalTo(bgView).offset(-30);
//    }];
//
//    NSString *pictureUrl = @"https://cn.bing.com/az/hprichbg/rb/PoniesWales_ZH-CN11520520997_1920x1080.jpg";
//    NSMutableArray *pictureArray = [NSMutableArray array];
//    for (NSInteger i = 0; i < 3; i++) {
//        [pictureArray addObject:pictureUrl];
//    }
//    pictureDisplayView.pictureArray = pictureArray;
    
}

@end
