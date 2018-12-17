//
//  SizeMacro.h
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#ifndef SizeMacro_h
#define SizeMacro_h

// 屏幕尺寸
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
// 原始屏幕尺寸
#define ABWidth    ((([UIScreen mainScreen].bounds.size.width)>([UIScreen mainScreen].bounds.size.height))?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.width))
#define ABHeight   ((([UIScreen mainScreen].bounds.size.width)>([UIScreen mainScreen].bounds.size.height))?([UIScreen mainScreen].bounds.size.width):([UIScreen mainScreen].bounds.size.height))

// status bar
#define STATUS_BAR_HEIGHT         (iPhoneXMore ? 44 : 20) // 44 20 [UIApplication sharedApplication].statusBarFrame.size.height
#define NAV_BAR_HEIGHT            (iPhoneXMore ? 88 : 64)
#define TOP_ESTIMATED_MARGIN      (iPhoneXMore ? 30 : 0)

// tab bar
#define TAB_BAR_HEIGHT            (iPhoneXMore ? 83 : 49)
#define TAB_BAR_BOTTOM_MARGIN     (iPhoneXMore ? 34 : 0)

#define iPhoneXSafeMargin         (iPhoneXMore ? 16 : 0) // 左右安全距离

// 一像素线的高
#define OnePXLineH (1.f/[UIScreen mainScreen].scale)

// 比例
#define ScaleX   SCREEN_WIDTH/375.f
#define ScaleY   SCREEN_HEIGHT/667.f

// 机型
#define iPhone4      (ABHeight == 480.f) // 640  * 480
#define iPhone5      (ABHeight == 568.f) // 640  * 1136
#define iPhone6      (ABHeight == 667.f) // 750  * 1334
#define iPhone6Plus  (ABHeight == 736.f) // 1242 * 2208
#define iPhoneX      (ABHeight == 812.f) // 1125 * 2436 (X XS)
#define iPhoneXR ([UIScreen mainScreen].scale == 2.0f && ABHeight == 896.f && ABWidth == 414.f) // 828 * 1792
#define iPhoneXMax ([UIScreen mainScreen].scale == 3.0f && ABHeight == 896.f && ABWidth == 414.f) // 1242 * 2688
#define iPhoneXMore (iPhoneX || iPhoneXR || iPhoneXMax)

#endif /* SizeMacro_h */
