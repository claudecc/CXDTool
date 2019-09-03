//
//  UIViewController+Extention.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "UIViewController+Extention.h"

@implementation UIViewController (Extention)

+ (void)load
{
    [self swizzled_methodInstanceSelector:@selector(viewDidAppear:) swizzleSelector:@selector(swizzled_viewDidAppear:)];
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

- (void)swizzled_viewDidAppear:(BOOL)animated {
    [self swizzled_viewDidAppear:animated];
}

- (void)addSubview:(UIView *)view {
    [self.view addSubview:view];
}

@end
