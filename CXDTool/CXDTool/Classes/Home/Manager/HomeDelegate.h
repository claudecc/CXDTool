//
//  HomeDelegate.h
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeVC.h"

typedef NS_ENUM(NSUInteger, HomeDelegateEvent) {
    HomeDelegateEventNone,
};

@interface HomeDelegate : NSObject

@property (nonatomic, weak) HomeVC *controller;

+ (HomeDelegate *)shareDelegate;

// 底->顶 : 对象 事件 数据
+ (void)actionView:(UIView *)view event:(NSUInteger)event message:(id)message;

+ (void)removeDelegate;

@end

