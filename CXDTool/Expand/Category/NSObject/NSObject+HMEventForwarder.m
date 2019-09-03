//
//  NSObject+HMEventForwarder.m
//  CXDTool
//
//  Created by claudechoi on 2019/4/19.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import "NSObject+HMEventForwarder.h"

@implementation NSObject (HMEventForwarder)

- (void)viewToVcEvent:(TriggerEvent)event message:(id)message {
    if ([self isKindOfClass:[UIView class]]) {
        UIViewController *currentVC = [self getCurrentVC];
        [currentVC viewToVcEvent:event message:message];
    } else if ([self isKindOfClass:[UIViewController class]]) {
        [UITool showToast:@"vc未实现"];
    }
}

@end
