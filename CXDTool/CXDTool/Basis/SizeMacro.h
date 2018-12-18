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

// iPhone机型
#define iPhone       [[UIDevice currentDevice].model isEqualToString:@"iPhone"]
#define iPhone4      (ABHeight == 480.f) // 320*480  640*960    @2x
#define iPhone5      (ABHeight == 568.f) // 320*568  640*1136   @2x
#define iPhone6      (ABHeight == 667.f) // 375*667  750*1334   @2x
#define iPhone6Plus  (ABHeight == 736.f) // 414*736  1242*2208  @3x
#define iPhoneX      (ABHeight == 812.f) // 375*812  1125*2436  @3x (X XS)
#define iPhoneXR ([UIScreen mainScreen].scale == 2.0f && ABHeight == 896.f && ABWidth == 414.f) // 414*896   828*1792 @2x
#define iPhoneXMax ([UIScreen mainScreen].scale == 3.0f && ABHeight == 896.f && ABWidth == 414.f) // 414*896   1242*2688 @3x
#define iPhoneXMore (iPhoneX || iPhoneXR || iPhoneXMax)

// iPad机型 mini2及之后:@2x 宽高比：除Pro11都是 0.75    pixel = point * scale
#define iPad          [[UIDevice currentDevice].model isEqualToString:@"iPad"]
//#define iPadMini      (ABHeight == 1024.f) // 7.9    1024*768  pt 2048*1536 px  (mini2及之后) 326
//#define iPad97        (ABHeight == 1024.f) // 9.7    1024*768  pt 2048*1536 px  (iPad Air、iPad Pro 9.7) 264
#define iPadDefault   (ABHeight == 1024.f)
#define iPadPro105    (ABHeight == 1112.f) // 10.5   1112*834  pt 2224*1668 px
#define iPadPro11     (ABHeight == 1194.f) // 11     1194*834  pt 2388*1668 px
#define iPadPro129    (ABHeight == 1366.f) // 12.9   1366*1024 pt 2732*2048 px


#endif /* SizeMacro_h */
