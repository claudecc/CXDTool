//
//  HomeInfoView.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "HomeInfoView.h"

@interface HomeInfoView ()
{
    struct {
        unsigned int didRespondsToTest : 1; // 占用1个二进制位,可以表示0或1这两个值
    } _delegateState;
    
}
@end

@implementation HomeInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor blueColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
}

- (void)setDelegate:(id<HomeInfoViewDelegate>)delegate {
    _delegate = delegate;
    _delegateState.didRespondsToTest = [delegate respondsToSelector:@selector(testSelector)];
}

- (void)tapAction {
//    [UITool showToast:@"点击"];
    if (_delegateState.didRespondsToTest) {
        [self.delegate testSelector];
    }
}

@end
