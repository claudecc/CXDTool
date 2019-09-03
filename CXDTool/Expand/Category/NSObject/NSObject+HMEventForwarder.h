//
//  NSObject+HMEventForwarder.h
//  CXDTool
//
//  Created by claudechoi on 2019/4/19.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 直播间触发事件 */
typedef NS_ENUM(NSUInteger, TriggerEvent) {
    TriggerEventDefault = 0,
};


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HMEventForwarder)

- (void)viewToVcEvent:(TriggerEvent)event message:(id)message;

@end

NS_ASSUME_NONNULL_END
