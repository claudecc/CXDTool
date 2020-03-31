//
//  UIView+XDSignal.m
//  JQService
//
//  Created by caixiaodong on 2020/3/26.
//  Copyright © 2020 caixiaodong. All rights reserved.
//

#import "UIView+XDSignal.h"
#import <objc/runtime.h>

static NSString *const signalDictKey = @"signalDictKey";
static NSString *const callbackKey = @"callbackKey";
static NSString *const appendParaObjKey = @"appendParaObjKey";
static NSString *const sendToTopQueueKey = @"sendToTopQueueKey";

@interface UIView ()

@property (nonatomic, strong) id appendParaObj;

@property (nonatomic, strong, readonly) NSMutableDictionary *signalDict;

@property (nonatomic, copy) XDSignalCallback callback;

@property (nonatomic, strong) NSOperationQueue *sendToTopQueue;

@end

@implementation UIView (XDSignal)

- (UIView *(^)(NSString *signal))sendSignalToTop {
    return ^ UIView *(NSString *signal) {
        if ([self isSignalEmpty:signal]) {
            return self;
        }
        UIView *superview = self.superview;
        while (superview) {
            if ([superview isExistSignalDict]) {
                XDSignalObserveBlock observeBlock = [superview.signalDict objectForKey:signal];
                if (observeBlock != nil) {
                    [self.sendToTopQueue addOperationWithBlock:^{
                        // a thread
                        __block id obj;
                        NSBlockOperation *observeOperation = [NSBlockOperation blockOperationWithBlock:^{
                            obj = observeBlock(self.appendParaObj);
                        }];
                        
                        if (self.callback) {
                            // wait observe block
                            [observeOperation setCompletionBlock:^{
                                // main thread
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    self.callback(obj);
                                }];
                            }];
                        }
                        [observeOperation start];
                    }];
                    break;
                }                
            }
            superview = superview.superview;
        }
        return self;
    };
}

- (void)triggerSignalToTop {
    
}

- (UIView *(^)(id obj))appendObj {
    return ^ UIView * (id obj) {
        self.appendParaObj = obj;
        return self;
    };
}

- (UIView *)appendCallback:(XDSignalCallback)callback {
    self.callback = callback;
    return self;
}

- (void)observeSignal:(NSString *)signal block:(XDSignalObserveBlock)block {
    if ([self isSignalEmpty:signal]) {
        return;
    }
    // register signal
    // add observe block
    [self.signalDict setObject:block forKey:signal];
}

- (BOOL)isRegisterSignal:(NSString *)signal {
    if ([self isSignalEmpty:signal]) {
        return NO;
    }
    XDSignalObserveBlock block = [self.signalDict objectForKey:signal];
    if (block) {
        return YES;
    }
    return NO;
}

- (BOOL)isSignalEmpty:(NSString *)signal {
    if (signal == nil || ![signal isKindOfClass:NSString.class] || signal.length == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isExistSignalDict {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &signalDictKey);
    if (dict) {
        return YES;
    }
    return NO;
}

#pragma mark - Setter / Getter

- (void)setAppendParaObj:(id)appendParaObj {
    objc_setAssociatedObject(self, &appendParaObjKey, appendParaObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)appendParaObj {
    id obj = objc_getAssociatedObject(self, &appendParaObjKey);
    return obj;
}

- (void)setCallback:(XDSignalCallback)callback {
    objc_setAssociatedObject(self, &callbackKey, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XDSignalCallback)callback {
    XDSignalCallback callback = objc_getAssociatedObject(self, &callbackKey);
    return callback;
}

- (NSOperationQueue *)sendToTopQueue {
    NSOperationQueue *queue = objc_getAssociatedObject(self, &sendToTopQueueKey);
    if (queue == nil) {
        queue = NSOperationQueue.alloc.init;
        queue.name = @"sendToTopQueue";
        objc_setAssociatedObject(self, &sendToTopQueueKey, queue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return queue;
}

- (NSMutableDictionary *)signalDict {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &signalDictKey);
    if (dict == nil) {
        dict = NSMutableDictionary.dictionary;
        objc_setAssociatedObject(self, &signalDictKey, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

@end
