//
//  HomeDelegate.h
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeVC.h"

// 模块类型（粒度未定）应该定义一个base delegate类，把模块类型ENUM放在里面，其他代理类继承base
typedef NS_ENUM(NSUInteger, HomeDelegateModuleType) {
    HomeDelegateModuleTypeHomeView,
};

typedef NS_ENUM(NSUInteger, HomeDelegateEvent) {
    HomeDelegateEventNone,
};

@interface HomeDelegate : NSObject

@property (nonatomic, weak) HomeVC *controller;

+ (HomeDelegate *)shareDelegate;

+ (void)removeDelegate;

// view -> vc : 对象 模块类 事件 数据
+ (void)actionObj:(NSObject *)obj
       moduleType:(HomeDelegateModuleType)moduleType
            event:(NSUInteger)event
          message:(id)message;
/*
 优点pros: 统一vc里所有的代理方法
 缺点cons: 本类里面会包含所有的类及ENUM
 */

/*
 vc -> view
 */

@end

