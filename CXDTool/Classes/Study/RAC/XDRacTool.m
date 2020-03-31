//
//  XDRacTool.m
//  CXDTool
//
//  Created by caixiaodong on 2020/3/26.
//  Copyright © 2020 claudechoi. All rights reserved.
//
/*
 @weakify(self)
 @strongify(self)
 */
/*
 简单使用
 //1、创建信号
 RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
     //任何时候，都可以发送信号，可以异步
     [subscriber sendNext:@"发送信号"];
     //数据传递完，最好调用sendCompleted，这时命令才执行完毕。
     [subscriber sendCompleted];
     return nil;
 }];
 //2、订阅信号
 RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
      //收到信号时
      NSLog(@"信号内容：%@", x);
 }];
 //取消订阅
 [disposable dispose];
 
 
 //UITextField创建了一个 `textSignal`的信号，并订阅了该信号
 //当UITextField的内容发生改变时，就会回调subscribeNext
 [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
      NSLog(@"text changed = %@", x);
 }];
 
 //当UITextField内输入的内容长度大于5时，才会回调subscribeNext
 [[[self.textField rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
       return value.length > 5;
 }] subscribeNext:^(NSString * _Nullable x) {
       NSLog(@"filter result = %@",  x);
 }];
 
 // ignore 对订阅的信号进行过滤
 [[[self.textField rac_textSignal] ignore:@"666"] subscribeNext:^(NSString * _Nullable x) {
     //当输入的内容 equalTo @"666" 时，这里不执行
     //其他内容，均会执行subscribeNext
     NSLog(@"ignore = %@", x);
 }];
 
 //当UIButton点击时，会调用subscribeNext
 [[self.button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
     NSLog(@"button clicked");
 }];
 
 //当UITextField输入的内容为@"666"时，bView视图的背景颜色变为grayColor
 RAC(self.bView, backgroundColor) = [self.textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
     return [value isEqualToString:@"666"]?[UIColor grayColor]:[UIColor orangeColor];
 }];
 
 */
#import "XDRacTool.h"

@implementation XDRacTool

- (void)test {
    
}

- (void)testArray {
    //数组遍历
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"遍历数组 %@",x);
    }];
    // 数组内容替换 并生成一个新的数组
    NSArray *newArray = [[array.rac_sequence mapReplace:@"one"] array];
    NSLog(@"newArray %@",newArray);
}

- (void)testTuples {
    //创建元祖
    RACTuple *tuple = [RACTuple tupleWithObjects:@"1", @"2", @"3", @"4", @"5", nil];

    // 从数组中获取内容
//    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
//    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray: array];

    //  宏创建
//    RACTuple *tuple = RACTuplePack(@"1", @"2", @"3", @"4", @"5");
//    NSLog(@"按下标取内容：%@", tuple[2]);
//    NSLog(@"第一个元素：%@", [tuple first]);
//    NSLog(@"最后一个元素：%@", [tuple last]);
}

- (void)testDict {
    // 字典遍历
    NSDictionary *dict = @{@"name":@"韩梅梅", @"age":@"19",@"lovers":@"╮(╯_╰)╭"};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"遍历字典 %@",x);
        //RACTupleUnpack 是个宏 可快速分开Key value
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"字典内容：%@:%@", key, value);
    }];
}

- (void)testButton {
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
//    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"😁哈哈哈");
    }];
}

- (void)testTimer {
    //多长时间后执行一次
    [[RACScheduler mainThreadScheduler]afterDelay:3 schedule:^{
        NSLog(@"3秒后执行一次");
    }];
    
    //takeUnti作用是  当控制器消失后取消执行
    RACDisposable *dispo=[[[RACSignal interval:2 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal ] subscribeNext:^(id x) {
        NSLog(@"每两秒执行一次");
    }];
    [dispo dispose]; //停止定时器
}

- (void)testObeserveSelector {
    //代替代理
//    [[self.subView rac_signalForSelector:@selector(btnClick)] subscribeNext:^(RACTuple * _Nullable x) {
//            NSLog(@" view 中的按钮被点击了");
//     }];
}

/*
 代理信号
 @property (nonatomic, strong) RACSubject *delegateSignal;
 创建
 [RACSubject subject]
 设置block
 [twoVc.delegateSignal subscribeNext:^(id x) {
     NSLog(@"点击了通知按钮");
 }];
 执行
 if (self.delegateSignal) {
     // 有值，才需要通知
     [self.delegateSignal sendNext:nil];
 }
 
 */

- (void)testKVO {
    [[self rac_valuesForKeyPath:@"name" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"name属性的改变：%@", x);
    }];
    //RACObserve 宏写法
    [RACObserve(self, self.description) subscribeNext:^(id  _Nullable x) {
        NSLog(@"name属性的改变111：%@", x);
    }];
}

- (void)testTextField {
    // 监听 TextField 的输入
//    [[textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"内容：%@", x);
//    }];
//    //也可以添加判断条件
//    [[textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//        return value.length > 10; // 文字长度 > 10 在监听
//    }] subscribeNext:^(NSString * _Nullable x) {
//
//         NSLog(@"输入框内容：%@", x);
//    }];
}

- (void)testNoti {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"notiName" object:nil] subscribeNext:^(id x) {
           NSLog(@"夜间模式:%@",x);
    }];
}

- (void)testGes {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
       [panGesture.rac_gestureSignal subscribeNext:^(id x) {
           NSLog(@"拖动手势:%@", x);
    }];
}

@end
