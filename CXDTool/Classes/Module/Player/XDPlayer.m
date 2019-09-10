//
//  XDPlayer.m
//  CXDTool
//
//  Created by 蔡晓东 on 2019/9/10.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import "XDPlayer.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface XDPlayer ()

@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@end

@implementation XDPlayer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    NSURL *url = [NSURL URLWithString:@""];

    IJKFFMoviePlayerController *player = [IJKFFMoviePlayerController.alloc initWithContentURL:url withOptions:nil];
    self.player = player;
    [self addSubview:player.view];
    [player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [player prepareToPlay];
    [player play];
}

- (void)pause {
    if (self.player) {
        [self.player pause];
    }
}

- (void)stop {
    if (self.player) {
        [self.player stop];
    }
}

- (void)shutdown {
    if (self.player) {
        [self.player shutdown];
    }
}

@end
