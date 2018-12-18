//
//  HomeDelegate.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "HomeDelegate.h"
#import "HomeView.h"
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

+ (void)actionObj:(NSObject *)obj
       moduleType:(HomeDelegateModuleType)moduleType
            event:(NSUInteger)event
          message:(id)message {
    [[HomeDelegate shareDelegate] actionObj:obj moduleType:moduleType event:event message:message];
}

- (void)actionObj:(NSObject *)obj
       moduleType:(HomeDelegateModuleType)moduleType
            event:(NSUInteger)event
          message:(id)message {
    switch (moduleType) {
        case HomeDelegateModuleTypeHomeView:
        {
            if ([obj isKindOfClass:[HomeInfoView class]]) {
                [self homeInfoView:(HomeInfoView *)obj event:event message:message];
            }
        }
            break;
        default:
        {
            [self obj:obj event:event message:message];
        }
            break;
    }
    
}

#pragma mark - Default delegate
- (void)obj:(NSObject *)obj event:(NSUInteger)event message:(id)message {
    HomeDelegateEvent delegateEvent = (HomeDelegateEvent)event;
    switch (delegateEvent) {
        case HomeDelegateEventNone:
        {
            [UITool showToast:@"Home Delegate 默认方法"];
        }
            break;
        default:
            break;
    }
}

#pragma mark - homeView delegate
// HomeInfo Delegate
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
