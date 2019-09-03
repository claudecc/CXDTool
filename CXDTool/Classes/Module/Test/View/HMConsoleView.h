//
//  HMConsoleView.h
//  HuoMao
//
//  Created by claudechoi on 2018/9/11.
//  Copyright © 2018年 火猫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMConsoleView : UIView

+ (instancetype)shareInstance;

+ (void)insertText:(NSString *)text;

- (void)insertText:(NSString *)text;

- (void)show;

- (void)hide;

@end
