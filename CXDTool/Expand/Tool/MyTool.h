//
//  MyTool.h
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyTool : NSObject

+ (BOOL)isLogin;

+ (NSString *)getStringFromObj:(id)obj;

+ (NSString *)filterHTML:(NSString *)html;

+ (NSRange)findKeyString:(NSString *)content;

//时间戳转时间
+ (NSString*)timestampSwitchTime:(NSString*)timestamp;

/** 区间随机数 */
+ (float)randomBetween:(float)smallerNumber And:(float)largerNumber;

CGSize GetTextSize(NSString *text, UIFont *font, CGFloat width);

NSInteger GetTabbarCurrentIndex(void);

NSInteger GetTabbarIndexWithVC(UIViewController *vc);

NSInteger GetTabbarCount(void);

/** 是否第一次进入（包括更新） */
BOOL isFirstLunch(void);

@end
