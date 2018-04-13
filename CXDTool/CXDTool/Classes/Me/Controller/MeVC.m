//
//  MeVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "MeVC.h"
#import "MeHeaderView.h"

@interface MeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MeHeaderView *headerView;
@property (nonatomic,assign) BOOL isAnimating;

@end

@implementation MeVC

- (NSArray *)dataArray {
    return @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    MeHeaderView *headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    self.headerView = headerView;
    [self.view addSubview:headerView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(headerView.height, 0, 0, 0);
    tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    UIView *transparentView = [[UIView alloc] initWithFrame:tableView.bounds];
    transparentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    tableView.backgroundView = transparentView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"me_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.headerView scrollWithOffsetY:scrollView.contentOffset.y];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 判断往下滑
    self.isAnimating = YES;
    MJWeakSelf
    // 做动画
    [self.headerView endingAnimateWithComplete:^{
        weakSelf.isAnimating = NO;
    }];
}

- (void)setIsAnimating:(BOOL)isAnimating {
    _isAnimating = isAnimating;
    if (isAnimating) {
        self.tableView.scrollEnabled = NO;
    } else {
        self.tableView.scrollEnabled = YES;
    }
}

@end
