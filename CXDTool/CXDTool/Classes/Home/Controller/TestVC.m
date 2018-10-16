//
//  TestVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/8/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "TestVC.h"
#import "MoreTaskView.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"控制台" style:UIBarButtonItemStylePlain target:self action:@selector(showConsoleView)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showConsoleView {
    for (NSInteger i = 0; i < 100; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((i+0.5) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [HMConsoleView insertText:[NSString stringWithFormat:@"收到了开放接口数据管理考试结果两节课--%ld--",i]];
        });
    }
}


@end
