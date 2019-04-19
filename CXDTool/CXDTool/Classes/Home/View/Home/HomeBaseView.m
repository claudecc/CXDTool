//
//  HomeBaseView.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/18.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "HomeBaseView.h"

@implementation HomeBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _delegateRespondsTo.homePublicDelegate = [self respondsToSelector:@selector(controller:vcEvent:message:)];
    }
    return self;
}

@end
