//
//  UIViewController+PopView.m
//  CXDTool
//
//  Created by claudechoi on 2019/4/19.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import "UIViewController+PopView.h"
#import <objc/runtime.h>
#import "PopFatherView.h"

@implementation UIViewController (PopView)

- (PopFatherView *)popFatherView {
    return objc_getAssociatedObject(self, _cmd);
}

- (PopFatherView *)getPopFatherView {
    @synchronized (self) {
        PopFatherView *view = self.popFatherView;
        if (!view) {
            UIViewController *vc = nil;
            if (self.tabBarController) {
                vc = self.tabBarController;
            } else if (self.navigationController) {
                vc = self.navigationController;
            } else {
                vc = self;
            }
            view = [[PopFatherView alloc] initWithFrame:vc.view.bounds];
            [vc.view addSubview:view];
            objc_setAssociatedObject(self, @selector(popFatherView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            NSLog(@"pop father : create%@",view);
        }
        return view;
    }
}

- (void)removePopFatherView {
    NSLog(@"pop father : remove%@",self.popFatherView);
    if (self.popFatherView) {
        [self.popFatherView removeFromSuperview];
    }
    objc_setAssociatedObject(self, @selector(popFatherView), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*
 一个view可能有多个vc共用
 所以不能以控制器的manager来转发
 最好是初始化view的时候就有某种绑定
 BaseEventManager
 view.manager = vc.manager;
 
 vc:
 - (void)eventDistribution {
 
 }
 
 [self.manager event: message:]
 
 view:
 [self.manager view: event: message:]
 
 */


@end
