//
//  UIViewController+PopView.h
//  CXDTool
//
//  Created by claudechoi on 2019/4/19.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class PopFatherView;
@interface UIViewController (PopView)

@property (nonatomic, strong, readonly) PopFatherView *popFatherView;

- (PopFatherView *)getPopFatherView;

- (void)removePopFatherView;

@end

NS_ASSUME_NONNULL_END
