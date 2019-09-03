//
//  PopFatherView.m
//  CXDTool
//
//  Created by claudechoi on 2019/4/19.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import "PopFatherView.h"
#import "UIViewController+PopView.h"

@interface PopFatherView ()

@property (nonatomic, strong) NSMutableDictionary *subviewsDict;

@end

@implementation PopFatherView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addNoti];
    }
    return self;
}

- (void)addNoti {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeSelf) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
}

- (void)removeNoti {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
}

- (void)addSubview:(UIView *)view level:(PopFatherViewLevel)level {
    
    if (level == PopFatherViewLevelDefault && self.subviews.count > 0) {
        
        NSInteger subIndex = -1;
        for (NSInteger i = 0; i < self.subviews.count; i++) {
            UIView *subview = self.subviews[i];
            NSString *address = [NSString stringWithFormat:@"%p",subview];
            PopFatherViewLevel subLevel = [[self.subviewsDict objectForKey:address] unsignedIntegerValue];
            if (subLevel == PopFatherViewLevelHigh) {
                // 存在高等级弹窗
                subIndex = i;
                break;
            }
        }
        
        if (subIndex == -1) {
            [super addSubview:view];
        } else {
            [super insertSubview:view atIndex:subIndex];
        }
        
    } else {
        [super addSubview:view];
    }
    
    NSString *address = [NSString stringWithFormat:@"%p",view];
    [self.subviewsDict setObject:@(level) forKey:address];
}

// 默认添加的都是低等级
- (void)addSubview:(UIView *)view {
    [self addSubview:view level:PopFatherViewLevelDefault];
}

- (void)removeSubview:(UIView *)view {
    NSString *address = [NSString stringWithFormat:@"%p",view];
    [self.subviewsDict removeObjectForKey:address];
    
    [view removeFromSuperview];
    if (self.subviews.count == 0) {
        [self removeSelf];
    }
}

- (void)removeSelf {
    // 调用vc清除fatherView
    UIViewController *currentVC = [self getCurrentVC];
    [currentVC removePopFatherView];
}

- (void)removeFromSuperview {
    [self removeNoti];
    [super removeFromSuperview];
}

- (NSMutableDictionary *)subviewsDict {
    if (!_subviewsDict) {
        _subviewsDict = [NSMutableDictionary dictionary];
    }
    return _subviewsDict;
}

@end
