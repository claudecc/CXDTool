//
//  VCManager.h
//  HuoMao
//
//  Created by claudechoi on 2018/8/30.
//  Copyright © 2018年 火猫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VCManager : NSObject
/**
 *  创建单例
 *
 *  @return VCManager
 */
+ (VCManager *)shareVCManager;

/**
 *  获取当前显示视图控制器
 *
 *  @return 当前顶层显示视图控制器
 */
- (UIViewController*)getTopViewController;

@end
