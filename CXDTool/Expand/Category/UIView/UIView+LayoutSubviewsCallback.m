//
//  UIView+LayoutSubviewsCallback.m
//  CXDTool
//
//  Created by claudechoi on 2018/8/24.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "UIView+LayoutSubviewsCallback.h"

@implementation UIView (LayoutSubviewsCallback)

+ (void)load {
    Method originalMethod = class_getInstanceMethod(self, @selector(layoutSubviews));
    Method newMethod = class_getInstanceMethod(self, @selector(xd_layoutSubviews));
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)xd_layoutSubviews {
    [self xd_layoutSubviews];
    
    if (self.layoutSubviewsCallback) {
        self.layoutSubviewsCallback(self);
    }
    
}

- (void)setLayoutSubviewsCallback:(void (^)(UIView *))layoutSubviewsCallback {
    objc_setAssociatedObject(self, "layoutSubviewsCallback", layoutSubviewsCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIView *))layoutSubviewsCallback {
    return objc_getAssociatedObject(self, "layoutSubviewsCallback");
}

@end
