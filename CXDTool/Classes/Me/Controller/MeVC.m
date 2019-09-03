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

@end

@implementation MeVC

- (NSArray *)dataArray {
    return @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navBarBgAlpha = @"0";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    MeHeaderView *headerView = [[MeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 340)];
    self.headerView = headerView;
    [self.view addSubview:headerView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(headerView.height, 0, 0, 0);
    tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    tableView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0,*)) {
        if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"me_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.headerView.isAnimating) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y+scrollView.contentInset.top;
    if (offsetY <= -self.headerView.dropOffsetH) {
        offsetY = -self.headerView.dropOffsetH;
        scrollView.contentOffset = CGPointMake(0, offsetY-scrollView.contentInset.top);
    }
    [self.headerView scrollWithOffsetY:offsetY];
    if (offsetY > 0) {
        self.navBarBgAlpha = [NSString stringWithFormat:@"%.2f",offsetY/70.0];
    } else {
        self.navBarBgAlpha = @"0.0";
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 判断往下滑
    CGFloat offsetY = scrollView.contentOffset.y+scrollView.contentInset.top;
    if (offsetY > 0) {
        return;
    }
    if (self.headerView.isAnimating) {
        return;
    }
    self.tableView.scrollEnabled = NO;
    MJWeakSelf
    // 做动画
    [self.headerView endingAnimateWithComplete:^{
        weakSelf.tableView.scrollEnabled = YES;
    }];
}

@end
