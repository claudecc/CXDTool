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
// 模块类型（粒度未定）
typedef NS_ENUM(NSUInteger, HomeEventModuleType) {
    HomeEventModuleTypeNone,
    HomeEventModuleTypeHomeView,
};

// objEvent: view -> vc 事件
typedef NS_ENUM(NSUInteger, HomeEventObjEvent) {
    HomeEventObjEventNone,
};

// vcEvent: vc -> view 事件
typedef NS_ENUM(NSUInteger, HomeEventVcEvent) {
    HomeEventVcEventNone,
};

@protocol HomeEventVCToViewDelegate <NSObject>

@optional
- (void)controller:(HomeVC *)controller vcEvent:(HomeEventVcEvent)vcEvent message:(id)message;

@end


#endif /* EventEnum_h */
