//
//  ImageProcessingVC.m
//  CXDTool
//
//  Created by 蔡晓东 on 2018/7/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "ImageProcessingVC.h"

@interface ImageProcessingVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *listArray;

@end

@implementation ImageProcessingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    self.tableView = tableview;
    tableview.delegate = self;
    tableview.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"ImageProcessingVC_cell_id";
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
    return @[@{@"name":@"Core Image",@"vc":@"CoreImageVC"},
             @{@"name":@"GPU Image",@"vc":@"GPUImageVC"}];
}

@end
