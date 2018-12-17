//
//  HomeInfoView.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "HomeInfoView.h"

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

- (void)tapAction {
//    [UITool showToast:@"点击"];
    [HomeDelegate actionObj:self type:HomeDelegateObjTypeHomeInfoView event:HomeInfoViewEventClick message:@"点击了"];
}

@end
