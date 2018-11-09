//
//  HMConsoleView.m
//  HuoMao
//
//  Created by claudechoi on 2018/9/11.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "HMConsoleView.h"

static NSString *cellId = @"HMConsoleViewCellId";

@interface HMConsoleView()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL isTableViewMoving;

@property (nonatomic, assign) CGPoint startTouchPoint;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HMConsoleView

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static HMConsoleView *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[HMConsoleView alloc] init];
    });
    return instance;
}

+ (void)insertText:(NSString *)text {
    [[HMConsoleView shareInstance] insertText:text];
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        [self layoutConfig];
    }
    return self;
}

- (void)setupUI {
    self.alpha = 0;
    [WINDOW addSubview:self];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:tableView];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [tableView addGestureRecognizer:tap];
    
}

- (void)layoutConfig {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(WINDOW);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(300);
    }];
}

- (void)insertText:(NSString *)text {
    
    [self.dataArray addObject:SafeString(text)];
    
    [self.tableView reloadData];
    
    if (self.dataArray.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (CGRectContainsPoint(self.tableView.frame, [touch locationInView:self])) { return NO; }
    return YES;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.tableView.frame, point)) {
        self.isTableViewMoving = YES;
        self.startTouchPoint = point;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    if (self.isTableViewMoving) {
        CGFloat offsetX = point.x - self.startTouchPoint.x;
        CGFloat offsetY = point.y - self.startTouchPoint.y;
        self.tableView.frame = CGRectMake(offsetX, offsetY, self.tableView.width, self.tableView.height);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isTableViewMoving = NO;
    CGFloat tableViewMaxX = self.tableView.maxX;
    CGFloat tableViewMaxY = self.tableView.maxY;
    CGFloat tableViewX = (self.tableView.x >= 0) ? ((tableViewMaxX <= SCREEN_WIDTH) ? :  (SCREEN_WIDTH - self.tableView.width)) : 0;
    CGFloat tableViewY = (self.tableView.y >= 0) ? ((tableViewMaxY <= SCREEN_HEIGHT) ? :  (SCREEN_HEIGHT - self.tableView.height)) : 0;
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.tableView.frame = CGRectMake(tableViewX, tableViewY, self.tableView.width, self.tableView.height);
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = SafeString(self.dataArray[indexPath.row]);
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont pingFangRegularFontWithSize:14];
    
    return cell;
}

- (void)show {
    [WINDOW bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
