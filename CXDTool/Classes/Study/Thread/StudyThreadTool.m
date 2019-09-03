//
//  StudyThreadTool.m
//  CXDTool
//
//  Created by 蔡晓东 on 2019/5/13.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import "StudyThreadTool.h"

@interface XDOperation : NSOperation

@end

@implementation XDOperation

- (void)main {
    if (!self.isCancelled) {
        NSLog(@"task operation");
    }
}

@end

@implementation StudyThreadTool
/**
 NSOperation、NSOperationQueue 是苹果提供给我们的一套多线程解决方案。实际上 NSOperation、NSOperationQueue 是基于 GCD 更高一层的封装，完全面向对象。但是比 GCD 更简单易用、代码可读性也更高。
 
 为什么要使用 NSOperation、NSOperationQueue？
 
 1.可添加完成的代码块，在操作完成后执行。
 2.添加操作之间的依赖关系，方便的控制执行顺序。
 3.设定操作执行的优先级。
 4.可以很方便的取消一个操作的执行。
 5.使用 KVO 观察对操作执行状态的更改：isExecuteing、isFinished、isCancelled。
 
 作者：行走少年郎
 链接：https://www.jianshu.com/p/4b1d77054b35
 来源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 */
- (void)testNSOperation {
    //    NSBlockOperation
    //    NSInvocationOperation
    //    NSOperationQueue
    
    
}

- (void)testInvocationOperation {
    void (^task1)(void) = ^{
        NSLog(@"invocation finished");
    };
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testTask1WithCompletion:) object:task1];
    [invocationOperation start];
}

- (void)testBlockOperation {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        [self testTask1WithCompletion:^{
            NSLog(@"tast1 finished");
        }];
    }];
    [blockOperation addExecutionBlock:^{
        [self testTask2WithCompletion:^{
            NSLog(@"task2 finished");
        }];
    }];
    [blockOperation start];
}

- (void)testAddOperationToQueue {
    // NSOperationQueue 一共有两种队列：主队列、自定义队列。
    
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    void (^task1)(void) = ^{
        NSLog(@"invocation task1 finished");
    };
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testTask1WithCompletion:) object:task1];
    void (^task2)(void) = ^{
        NSLog(@"invocation task1 finished");
    };
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(testTask1WithCompletion:) object:task2];
    
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        [self testTask1WithCompletion:^{
            NSLog(@"block tast3 finished");
        }];
    }];
    [op3 addExecutionBlock:^{
        [self testTask1WithCompletion:^{
            NSLog(@"block tast4 finished");
        }];
    }];
    
    [queue addOperation:op1];
    [queue addOperation:op2];
    [queue addOperation:op3];
}

- (void)testAddOperationWithBlockToQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.设置最大并发操作数
    queue.maxConcurrentOperationCount = 1; // 串行队列
    // queue.maxConcurrentOperationCount = 2; // 并发队列
    // queue.maxConcurrentOperationCount = 8; // 并发队列
    
    [queue addOperationWithBlock:^{
        [self testTask1WithCompletion:^{
            NSLog(@"queue task1 finished");
        }];
    }];
    [queue addOperationWithBlock:^{
        [self testTask1WithCompletion:^{
            NSLog(@"queue task2 finished");
        }];
    }];
    [queue addOperationWithBlock:^{
        [self testTask1WithCompletion:^{
            NSLog(@"queue task3 finished");
        }];
    }];
}

- (void)testAddDependency {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    
    // 3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2
    
    // 4.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
}

- (void)testCommunication {
    
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 异步进行耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
        
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 进行一些 UI 刷新等操作
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
    }];
}

- (void)testTask1WithCompletion:(void (^)(void))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        });
    });
}

- (void)testTask2WithCompletion:(void (^)(void))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        });
    });
}

- (void)testTask3WithCompletion:(void (^)(void))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        });
    });
}

- (void)testTask4WithCompletion:(void (^)(void))completion {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        });
    });
}

@end
