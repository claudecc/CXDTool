//
//  PhysicsVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/4/3.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "PhysicsVC.h"

@interface PhysicsVC ()

@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong) UIDynamicAnimator *animator;

@end

@implementation PhysicsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self gravity1];
}

- (void)gravity1 {
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.redView];
    [self.animator addBehavior:gravity];
}

- (void)gravity2 {
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] init];
    [gravity addItem:self.redView];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] init];
    [collision addItem:self.redView];
    
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
        _redView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_redView];
    }
    return _redView;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

@end
