//
//  PopFatherView.h
//  CXDTool
//
//  Created by claudechoi on 2019/4/19.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PopFatherViewLevel) {
    PopFatherViewLevelDefault,
    PopFatherViewLevelHigh,
};

@interface PopFatherView : UIView
/** addSubview添加的是Default */
- (void)addSubview:(UIView *)view level:(PopFatherViewLevel)level;

- (void)removeSubview:(UIView *)view;

@end


NS_ASSUME_NONNULL_END
