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

#define NAV_BAR_HEIGHT            (IS_IPHONE_X ? 88 : 64)
#define STATUS_BAR_HEIGHT         (IS_IPHONE_X ? 44 : 20)
#define STATUS_BAR_TOP_MARGIN     (IS_IPHONE_X ? 24 : 0)
#define TOP_ESTIMATED_MARGIN      (IS_IPHONE_X ? 30 : 0)
#define STATUS_BAR_HEIGHT_ONLY_X  (IS_IPHONE_X ? 44 : 0)

#define TAB_BAR_HEIGHT            (IS_IPHONE_X ? 83 : 49)
#define TAB_BAR_BOTTOM_MARGIN     (IS_IPHONE_X ? 34 : 0)

// 比例
#define ScaleX   SCREEN_WIDTH/375
#define ScaleY   SCREEN_HEIGHT/667

// 判断
#define IS_IPHONE_X     (SCREEN_HEIGHT == 812)
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

#endif /* BasicMacro_h */
