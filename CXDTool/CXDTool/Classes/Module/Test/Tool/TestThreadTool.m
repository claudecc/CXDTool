//
//  TestThreadTool.m
//  CXDTool
//
//  Created by 蔡晓东 on 2019/5/10.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import "TestThreadTool.h"

@implementation TestThreadTool

/**
 NSOperation、NSOperationQueue 是苹果提供给我们的一套多线程解决方案。实际上 NSOperation、NSOperationQueue 是基于 GCD 更高一层的封装，完全面向对象。但是比 GCD 更简单易用、代码可读性也更高。
 为什么要使用 NSOperation、NSOperationQueue？
 
 可添加完成的代码块，在操作完成后执行。
 添加操作之间的依赖关系，方便的控制执行顺序。
 设定操作执行的优先级。
 可以很方便的取消一个操作的执行。
 使用 KVO 观察对操作执行状态的更改：isExecuteing、isFinished、isCancelled。
 
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
