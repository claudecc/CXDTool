//
//  UIView+LayoutSubviewsCallback.h
//  CXDTool
//
//  Created by claudechoi on 2018/8/24.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutSubviewsCallback)

@property (nonatomic, copy) void (^layoutSubviewsCallback)(UIView *view);

@end
