//
//  HomeDelegate.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "HomeDelegate.h"
#import "HomeInfoView.h"

@implementation HomeDelegate

static HomeDelegate *_delegate;
static dispatch_once_t _onceToken;

+ (HomeDelegate *)shareDelegate
{
    dispatch_once(&_onceToken, ^{
        _delegate = [[self alloc] init];
    });
    
    return _delegate;
}

+ (void)removeDelegate {
    _onceToken = 0;
    _delegate = nil;
}

+ (void)actionView:(UIView *)view event:(NSUInteger)event message:(id)message {
    [[HomeDelegate shareDelegate] actionView:view event:event message:message];
}

- (void)actionView:(UIView *)view event:(NSUInteger)event message:(id)message {
    if ([view isKindOfClass:[HomeInfoView class]]) {
        [self homeInfoView:(HomeInfoView *)view event:event message:message];
    }
    else {
        [self view:view event:event message:message];
    }
}

#pragma mark - Default delegate
- (void)view:(UIView *)view event:(NSUInteger)event message:(id)message {
    HomeDelegateEvent delegateEvent = (HomeDelegateEvent)event;
    switch (delegateEvent) {
        case HomeDelegateEventNone:
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - HomeInfo Delegate
- (void)homeInfoView:(HomeInfoView *)view event:(NSUInteger)event message:(id)message {
    HomeInfoViewEvent infoEvent = (HomeInfoViewEvent)event;
    switch (infoEvent) {
        case HomeInfoViewEventClick:
        {
            NSString *text = (NSString *)message;
            [UITool showToast:text];
            
        }
            break;
        default:
            break;
    }
}

@end
