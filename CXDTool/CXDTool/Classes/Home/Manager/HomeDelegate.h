//
//  HomeDelegate.h
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeVC.h"

// 模块类型（粒度未定）
typedef NS_ENUM(NSUInteger, HomeDelegateObjType) {
    HomeDelegateObjTypeHomeInfoView,
};

typedef NS_ENUM(NSUInteger, HomeDelegateEvent) {
    HomeDelegateEventNone,
};

@interface HomeDelegate : NSObject

@property (nonatomic, weak) HomeVC *controller;

+ (HomeDelegate *)shareDelegate;

+ (void)removeDelegate;

// 底->顶 : 对象 对象类型 事件 数据
+ (void)actionObj:(NSObject *)obj type:(HomeDelegateObjType)type event:(NSUInteger)event message:(id)message;
/*
 优点pros: 统一vc里所有的代理方法
 缺点cons: 本类里面会包含所有的类及ENUM
 */


@end

