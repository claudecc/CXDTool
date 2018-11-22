//
//  TabbarControllerAnimation.m
//  CXDTool
//
//  Created by claudechoi on 2018/11/22.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "TabbarControllerAnimation.h"

@implementation TabbarControllerAnimation

static UIView *presentingView;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 获取fromVc和toVc
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = [[UIView alloc] init];;
    UIView *toView = [[UIView alloc] init];
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        // fromVc 的view
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        // toVc的view
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else {
        // fromVc 的view
        fromView = fromVc.view;
        // toVc的view
        toView = toVc.view;
    }
    
    CGFloat x = [UIScreen mainScreen].bounds.size.width;
    NSInteger fromIndex = GetTabbarIndexWithVC(fromVc);
    NSInteger toIndex = GetTabbarIndexWithVC(toVc);
    if (fromIndex < toIndex) {
        x = -x;//根据title判断是从哪个控制器跳转到哪个控制器 设置动画的方向
    }
    
    // 转场环境
    UIView *containView = [transitionContext containerView];
    toView.frame = CGRectMake(-x, 0, containView.frame.size.width, containView.frame.size.height);
    
    [containView addSubview:fromView];
    [containView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        fromView.transform = CGAffineTransformTranslate(fromView.transform, x, 0);
        toView.transform = CGAffineTransformTranslate(toView.transform, x, 0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
