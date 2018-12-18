//
//  HomeVC.h
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "BaseVC.h"
#import "HomeBaseView.h"

@interface HomeVC : BaseVC

- (HomeBaseView *)getModuleViewWithModuleType:(HomeDelegateModuleType)moduleType;

- (void)showText:(NSString *)text;

@end
