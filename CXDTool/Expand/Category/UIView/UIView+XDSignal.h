//
//  UIView+XDSignal.h
//  JQService
//
//  Created by caixiaodong on 2020/3/26.
//  Copyright © 2020 caixiaodong. All rights reserved.
//

/*
 Usage:
 Top level
 [self observeSignal:@"clickBtn" block:^id(id obj) {
     __block id obj = nil;
     dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC);
     dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
     ^() {
        dispatch_semaphore_signal(semaphore);
     };
     dispatch_semaphore_wait(semaphore, timeout);
     return obj;
 }];
 
 bottom level
 [self.appendObj(GetPureString(self.model.userInfo.auth_id)) appendCallback:^(id obj) {
     
 }].sendSignalToTop(@"followSignal");
 */

#import <UIKit/UIKit.h>

typedef id(^XDSignalObserveBlock)(id obj);
typedef void (^XDSignalCallback)(id obj);

@interface UIView (XDSignal)

/*
 deliver event to top level
 */
/** sendSignalToTop used at the end */
@property (nonatomic, copy, readonly) UIView *(^sendSignalToTop)(NSString *signal);

@property (nonatomic, copy, readonly) UIView *(^appendObj)(id obj);

/** callback is a main thread */
- (UIView *)appendCallback:(XDSignalCallback)callback;

/** block is a child thread */
- (void)observeSignal:(NSString *)signal block:(XDSignalObserveBlock)block;

- (BOOL)isRegisterSignal:(NSString *)signal;

@end
