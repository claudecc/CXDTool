//
//  SegmentVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/4/3.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "SegmentVC.h"

@interface SegmentVC ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *firstTableView;

@end

@implementation SegmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    }
    
    [self setupUI];
}

- (void)setupUI {
    CGFloat headerH = 150;
    CGFloat barH = 50;
    UIScrollView *scrollView = [UIScrollView.alloc initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView setContentSize:CGSizeMake(self.view.width, self.view.height+headerH+barH)];
    scrollView.showsVerticalScrollIndicator = NO;
    
    UIView *headerView = [UIView.alloc initWithFrame:CGRectMake(0, 0, self.view.width, headerH)];
    [scrollView addSubview:headerView];
    headerView.backgroundColor = UIColor.redColor;

    UIView *barView = [UIView.alloc initWithFrame:CGRectMake(0, 150, self.view.width, barH)];
    [scrollView addSubview:barView];
    barView.backgroundColor = UIColor.yellowColor;
    
    UIScrollView *horizontalScrollView = [UIScrollView.alloc initWithFrame:CGRectMake(0, 200, self.view.width, self.view.height)];
    [scrollView addSubview:horizontalScrollView];
    
    for (NSInteger i = 0; i < 3; i++) {
        UITableView *tableView = [UITableView.alloc initWithFrame:CGRectMake(i*self.view.width, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        [horizontalScrollView addSubview:tableView];
        if (i == 0) {
            self.firstTableView = tableView;
        }
    }
    
}

@end
