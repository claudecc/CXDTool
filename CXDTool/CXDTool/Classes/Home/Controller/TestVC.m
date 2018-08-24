//
//  TestVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/8/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "TestVC.h"
#import "HPVIDCompetitionVideoCell.h"
#import "CompetitionCommentatorView.h"

@interface TestVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CompetitionCommentatorView *view = [[CompetitionCommentatorView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
    [self.view addSubview:view];
    
//    UITableView *tab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    [self.view addSubview:tab];
//    tab.delegate = self;
//    tab.dataSource = self;
//    tab.rowHeight = 136;
//    tab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    [tab reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 , 8  , 64 , 16)];
    titleLabel.text = @"视频推荐";
    titleLabel.font = [UIFont systemFontOfSize:16.f];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    titleLabel.adjustsFontSizeToFitWidth = YES;
    [view addSubview:titleLabel];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HPVIDCompetitionVideoCell *cell = [HPVIDCompetitionVideoCell cellWithTableView:tableView];
    cell.listArray = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    return cell;
}



@end
