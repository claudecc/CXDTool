//
//  TestVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/8/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "TestVC.h"
#import "PictureBrowserHeader.h"

static const CGFloat headH = 200;

@interface TestVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL isSticky;
@property (nonatomic, strong) UIView *headView;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isSticky = YES;
    [self createTableview];
    [self.view addSubview:self.headView];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    label.text = [NSString stringWithFormat:@"第%ld组",(long)section];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个",(long)indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isSticky = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    if (y == headH) {
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)createTableview {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor orangeColor];
    tableView.contentInset = UIEdgeInsetsMake(headH, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, headH)];
        _headView.backgroundColor = [UIColor blueColor];
    }
    return _headView;
}

@end
