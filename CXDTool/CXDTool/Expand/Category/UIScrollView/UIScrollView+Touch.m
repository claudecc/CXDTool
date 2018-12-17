//
//  UIScrollView+Touch.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "UIScrollView+Touch.h"

@implementation UIScrollView (Touch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self isMemberOfClass:[UIScrollView class]]) {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesBegan:touches withEvent:event];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self isMemberOfClass:[UIScrollView class]]) {
        [[self nextResponder] touchesMoved:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesMoved:withEvent:)]) {
            [super touchesMoved:touches withEvent:event];
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self isMemberOfClass:[UIScrollView class]]) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesEnded:withEvent:)]) {
            [super touchesEnded:touches withEvent:event];
        }
    }
}

@end
