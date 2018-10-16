//
//  BasicMacro.h
//  CXDTool
//
//  Created by claudechoi on 2018/4/28.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#ifndef BasicMacro_h
#define BasicMacro_h

// 尺寸
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define StatusHeight [UIApplication sharedApplication].statusBarFrame.size.height

#define ABWidth    ((([UIScreen mainScreen].bounds.size.width)>([UIScreen mainScreen].bounds.size.height))?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.width))
#define ABHeight   ((([UIScreen mainScreen].bounds.size.width)>([UIScreen mainScreen].bounds.size.height))?([UIScreen mainScreen].bounds.size.width):([UIScreen mainScreen].bounds.size.height))


#define NAV_BAR_HEIGHT            (IS_IPHONE_X ? 88 : 64)
#define STATUS_BAR_HEIGHT         (IS_IPHONE_X ? 44 : 20)
#define STATUS_BAR_TOP_MARGIN     (IS_IPHONE_X ? 24 : 0)
#define TOP_ESTIMATED_MARGIN      (IS_IPHONE_X ? 30 : 0)
#define STATUS_BAR_HEIGHT_ONLY_X  (IS_IPHONE_X ? 44 : 0)

#define TAB_BAR_HEIGHT            (IS_IPHONE_X ? 83 : 49)
#define TAB_BAR_BOTTOM_MARGIN     (IS_IPHONE_X ? 34 : 0)

// 一像素线的高
#define OnePXLineH (1.f/[UIScreen mainScreen].scale)

// 比例
#define ScaleX   SCREEN_WIDTH/375
#define ScaleY   SCREEN_HEIGHT/667

// 机型
#define iPhone4      (HMHeight == 480.f)
#define iPhone5      (HMHeight == 568.f)
#define iPhone6      (HMHeight == 667.f)
#define iPhone6Plus  (HMHeight == 736.f)
#define IS_IPHONE_X     (SCREEN_HEIGHT == 812)
#define iPhoneXR ([UIScreen mainScreen].scale == 2.0f && HMHeight == 896.f && HMWidth == 414.f)
#define iPhoneXMax ([UIScreen mainScreen].scale == 3.0f && HMHeight == 896.f && HMWidth == 414.f)

/**
 *  判断屏幕尺寸是否为640*1136 5s,5
 *
 *    @return    判断结果（YES:是 NO:不是）
 */
#define DEF_SCREEN_IS_5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


/**
 *  判断屏幕尺寸是否为750*1334  6
 *
 *    @return    判断结果（YES:是 NO:不是）
 */
#define DEF_SCREEN_IS_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  判断屏幕尺寸是否为1080*1920 6plus
 *
 *    @return    判断结果（YES:是 NO:不是）
 */

#define DEF_SCREEN_IS_6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)


#define XDWeakSelf __weak typeof(&*self) weakSelf = self;
#define XDStrongSelf(_ref) __strong typeof(&*self) strongSelf = _ref;

#define WINDOW [UIApplication sharedApplication].keyWindow

#endif /* BasicMacro_h */
