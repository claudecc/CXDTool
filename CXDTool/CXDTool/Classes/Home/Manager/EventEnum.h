//
//  EventEnum.h
//  CXDTool
//
//  Created by claudechoi on 2018/12/18.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#ifndef EventEnum_h
#define EventEnum_h

@class HomeVC;
// 模块类型（粒度未定）应该定义一个base delegate类，把模块类型ENUM放在里面，其他代理类继承base
typedef NS_ENUM(NSUInteger, HomeDelegateModuleType) {
    HomeDelegateModuleTypeNone,
    HomeDelegateModuleTypeHomeView,
};

// objEvent: view -> vc 事件
typedef NS_ENUM(NSUInteger, HomeDelegateObjEvent) {
    HomeDelegateObjEventNone,
};

// vcEvent: vc -> view 事件
typedef NS_ENUM(NSUInteger, HomeDelegateVcEvent) {
    HomeDelegateVcEventNone,
};

@protocol HomeEventVCToViewDelegate <NSObject>

@optional
- (void)controller:(HomeVC *)controller vcEvent:(HomeDelegateVcEvent)vcEvent message:(id)message;

@end


#endif /* EventEnum_h */
