//
//  NSObject+Crash.m
//  HuoMao
//
//  Created by ZH on 2017/8/28.
//  Copyright © 2017年 火猫. All rights reserved.
//

#import "NSObject+Crash.h"
#import <objc/runtime.h>

@implementation NSObject (Crash)

static NSString *_errorFunctionName;
#pragma mark - 空方法
void dynamicMethodIMP(id self,SEL _cmd){
    
}

+ (void)load
{
    [self swizzled_methodInstanceSelector:@selector(methodSignatureForSelector:) swizzleSelector:@selector(swizzled_methodSignatureForSelector:)];
    [self swizzled_methodInstanceSelector:@selector(forwardInvocation:) swizzleSelector:@selector(swizzled_forwardInvocation:)];
}


+ (void)swizzled_methodInstanceSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector {
    // 获取原有方法
    Method origMethod = class_getInstanceMethod(self,origSelector);
    // 获取交换方法
    Method swizzleMethod = class_getInstanceMethod(self,swizzleSelector);
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }else {
        class_replaceMethod(self, swizzleSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
}


- (NSMethodSignature *)swizzled_methodSignatureForSelector:(SEL)aSelector{
    if (![self respondsToSelector:aSelector]) {
        _errorFunctionName = NSStringFromSelector(aSelector);
        Class class = NSClassFromString(@"SKInvocationQueueProxy");
        NSMethodSignature *methodSignature = [self swizzled_methodSignatureForSelector:aSelector];
        if ([_errorFunctionName hasPrefix:@"CAD"] || [self isKindOfClass:class]) {
            return methodSignature;
        }
        if (class_addMethod([self class], aSelector, (IMP)dynamicMethodIMP, "v@:")) {
            NSLog(@"出现奔溃,拦截unrecognized selector sent to instance导致的崩溃");

#if DEBUG
            NSString *classSt = NSStringFromClass([self class]);
            NSString *methods = NSStringFromSelector(aSelector);
            NSString *message = [NSString stringWithFormat:@"%@/n%@",classSt,methods];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"出现崩溃,拦截到方法" message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            UIViewController *vc = [[VCManager shareVCManager] getTopViewController];
            [vc presentViewController:alert animated:YES completion:nil];
#endif
            
        }
        if (!methodSignature) {
            methodSignature = [self swizzled_methodSignatureForSelector:aSelector];
        }
        
        return methodSignature;
        
    }else{
        return [self swizzled_methodSignatureForSelector:aSelector];
    }
}

- (void)swizzled_forwardInvocation:(NSInvocation *)anInvocation{
    SEL selector = [anInvocation selector];
    if ([self respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:self];
    }else{
        [self swizzled_forwardInvocation:anInvocation];
    }
}

@end
