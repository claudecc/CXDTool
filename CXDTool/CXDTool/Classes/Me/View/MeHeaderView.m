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

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
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
    [self insertSubview:cardView belowSubview:bgView];
    self.cardView = cardView;
    cardView.backgroundColor = [UIColor blackColor];
    
}

- (void)scrollWithOffsetY:(CGFloat)offsetY {
    
}

- (void)endingAnimateWithComplete:(void (^)(void))complete {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (complete) {
            complete();
        }
        
    });
}

@end
