//
//  HomeEventManager.h
//  CXDTool
//
//  Created by claudechoi on 2018/12/18.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeVC;
@protocol HomeEventVCToViewDelegate;

@interface HomeEventManager : NSObject

@property (nonatomic, weak) HomeVC *controller;

@property (nonatomic, weak) id<HomeEventVCToViewDelegate> viewDelegate;

+ (HomeEventManager *)shareManager;

+ (void)removeManager;

/**
 view -> vc

 @param obj 对象
 @param moduleType 模块类
 @param objEvent 事件
 @param message 数据
 */
+ (void)actionObj:(NSObject *)obj
       moduleType:(HomeEventModuleType)moduleType
         objEvent:(NSUInteger)objEvent
          message:(id)message;

/**
 vc -> view

 @param moduleType 模块类
 @param vcEvent 事件
 @param message 数据
 */
+ (void)targetModuleType:(HomeEventModuleType)moduleType
                 vcEvent:(HomeEventVcEvent)vcEvent
                 message:(id)message;

@end
