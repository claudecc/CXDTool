//
//  HomeView.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "HomeView.h"
#import "HomeInfoView.h"

@interface HomeView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) HomeInfoView *infoView;

@end

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupUI {
    HomeInfoView *view = [[HomeInfoView alloc] initWithFrame:CGRectMake(40, 40, 200, 200)];
    [self addSubview:view];
    self.infoView = view;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    CGPoint touchLocation = [touch locationInView:self];
//    if (CGRectContainsPoint(self.infoView.frame, touchLocation)) return NO;
//    return YES;
//}

- (void)hide {
    [self removeFromSuperview];
}

@end
