//
//  HomeVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "HomeVC.h"
#import "HomeEventManager.h"
#import "HomeView.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, weak) HomeView *homeView;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [HomeEventManager shareManager].controller = self;
}

- (void)setupUI {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    self.tableView = tableview;
    tableview.delegate = self;
    tableview.dataSource = self;
    
}

#pragma mark - public

- (HomeBaseView *)getModuleViewWithModuleType:(HomeEventModuleType)moduleType {
    HomeBaseView *view = nil;
    switch (moduleType) {
        case HomeEventModuleTypeHomeView:
        {
            view = self.homeView;
        }
            break;
        default:
            break;
    }
    return view;
}

- (void)showText:(NSString *)text {
    [UITool showToast:text];
}

#pragma mark - private

- (void)showHomeView {
    HomeView *view = [[HomeView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    self.homeView = view;
}

- (void)leftItemAction {
    [self showHomeView];
}

- (void)rightItemAction {
    [HomeEventManager targetModuleType:HomeEventModuleTypeHomeView vcEvent:HomeEventVcEventNone message:@"vc -> view"];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"home_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [self.listArray[indexPath.row] objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vc = [self.listArray[indexPath.row] objectForKey:@"vc"];
    NSString *vcName = [self.listArray[indexPath.row] objectForKey:@"name"];
    Class class = NSClassFromString(vc);
    if (class) {
        BaseVC *vc = [[class alloc] init];
        vc.title = vcName;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSArray *)listArray {
    return @[@{@"name":@"banner",@"vc":@"BannerVC"},
             @{@"name":@"segment",@"vc":@"SegmentVC"},
             @{@"name":@"瀑布流",@"vc":@"FlowLayoutVC"},
             @{@"name":@"物理动画",@"vc":@"PhysicsVC"},
             @{@"name":@"图像处理",@"vc":@"ImageProcessingVC"},
             @{@"name":@"测试",@"vc":@"TestVC"}];
}

- (void)dealloc {
    [HomeEventManager removeManager];
    DLog(@"");
}

@end
