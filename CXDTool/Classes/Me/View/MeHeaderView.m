//
//  MeHeaderView.m
//  CXDTool
//
//  Created by claudechoi on 2018/4/13.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "MeHeaderView.h"

@interface MeHeaderView()

@property (nonatomic,strong) UIView *topBgView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *cardView;

@end

@implementation MeHeaderView
{
    CGFloat _cardViewOriginY;
    CGFloat _offsetY;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -10, self.width, 200)];
    [self addSubview:topBgView];
    self.topBgView = topBgView;
    topBgView.backgroundColor = [UIColor redColor];
    
    CGFloat bgX = 20;
    CGFloat bgW = self.width - 2*bgX;
    CGFloat bgY = 100;
    CGFloat bgH = 200;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(bgX, bgY, bgW, bgH)];
    [self addSubview:bgView];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor cyanColor];
    
    UIView *cardView = [[UIView alloc] initWithFrame:bgView.frame];
    cardView.y += 30;
    _cardViewOriginY = cardView.y;
    [self insertSubview:cardView belowSubview:bgView];
    self.cardView = cardView;
    cardView.backgroundColor = [UIColor blackColor];
    
}

- (CGFloat)dropOffsetH {
    return self.cardView.height*0.5;
}

- (void)scrollWithOffsetY:(CGFloat)offsetY {
    _offsetY = offsetY;
    if (offsetY >= 0) {
        self.y = -offsetY;
        self.topBgView.transform = CGAffineTransformMakeScale(1, 1);
        if (self.cardView.y != _cardViewOriginY) {
            self.cardView.y = _cardViewOriginY;
        }
    } else {
        if (self.y != 0) {
            self.y = 0;
        }
        self.cardView.y = _cardViewOriginY + fabs(offsetY);
        self.topBgView.transform = CGAffineTransformMakeScale(1, 1+0.0005*fabs(offsetY));
    }
}

- (void)endingAnimateWithComplete:(void (^)(void))complete {
    if (_offsetY == 0) {
        return;
    }
    self.isAnimating = YES;
    /**
     dampingRatio:0~1 ，越小效果越大
     */
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.topBgView.transform = CGAffineTransformMakeScale(1, 1);
        self.cardView.y = _cardViewOriginY;
    } completion:^(BOOL finished) {
        self.isAnimating = NO;
        complete();
    }];
}

@end
