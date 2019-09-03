//
//  HomeEventManager.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/18.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "HomeEventManager.h"
#import "HomeView.h"
#import "HomeInfoView.h"
#import "HomeVC.h"

@implementation HomeEventManager

static HomeEventManager *_manager;
static dispatch_once_t _onceToken;

+ (HomeEventManager *)shareManager
{
    dispatch_once(&_onceToken, ^{
        _manager = [[self alloc] init];
    });
    
    return _manager;
}

+ (void)removeManager {
    _manager = nil;
    _onceToken = 0;
}

- (HomeVC *)controller {
    if (!_controller) {
        UIViewController *currentVC = [[VCManager shareVCManager] getTopViewController];
        if ([currentVC isKindOfClass:[HomeVC class]]) {
            _controller = (HomeVC *)currentVC;
        }
    }
    return _controller;
}

#pragma mark -
#pragma mark - view -> vc

+ (void)actionObj:(NSObject *)obj
       moduleType:(HomeEventModuleType)moduleType
         objEvent:(NSUInteger)objEvent
          message:(id)message {
    [[HomeEventManager shareManager] actionObj:obj moduleType:moduleType objEvent:objEvent message:message];
}

- (void)actionObj:(NSObject *)obj
       moduleType:(HomeEventModuleType)moduleType
         objEvent:(NSUInteger)objEvent
          message:(id)message {
    switch (moduleType) {
        case HomeEventModuleTypeHomeView:
        {
            if ([obj isKindOfClass:[HomeInfoView class]]) {
                [self homeInfoView:(HomeInfoView *)obj event:objEvent message:message];
            }
        }
            break;
        default:
        {
            [self obj:obj objEvent:objEvent message:message];
        }
            break;
    }
    
}

#pragma mark - Default delegate
- (void)obj:(NSObject *)obj objEvent:(NSUInteger)objEvent message:(id)message {
    HomeEventObjEvent delegateEvent = (HomeEventObjEvent)objEvent;
    switch (delegateEvent) {
        case HomeEventObjEventNone:
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
            [self.controller showText:message];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark - vc -> view
+ (void)targetModuleType:(HomeEventModuleType)moduleType
                 vcEvent:(HomeEventVcEvent)vcEvent
                 message:(id)message {
    [[HomeEventManager shareManager] targetModuleType:moduleType vcEvent:vcEvent message:message];
}

- (void)targetModuleType:(HomeEventModuleType)moduleType
                 vcEvent:(HomeEventVcEvent)vcEvent
                 message:(id)message {
    switch (moduleType) {
        case HomeEventModuleTypeHomeView:
        {
            HomeBaseView *view = [self.controller getModuleViewWithModuleType:moduleType];
            if (view && view->_delegateRespondsTo.homePublicDelegate) {
                self.viewDelegate = view;
            }
        }
            break;
        default:
        {
            
        }
            break;
    }
    
    if (self.viewDelegate) {
        [self.viewDelegate controller:self.controller vcEvent:vcEvent message:message];
    } else {
        [UITool showToast:@"don't responds to selector"];
    }
    
}

@end
