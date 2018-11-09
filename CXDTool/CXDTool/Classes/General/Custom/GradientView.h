//
//  GradientView.h
//  CXDTool
//
//  Created by 蔡晓东 on 2018/11/9.
//  Copyright © 2018 claudechoi. All rights reserved.
//

/**
 gradient layer autolayout 渐变自动布局解决方案
 
 示例：
 HMGradientView *gradientView = [[HMGradientView alloc] init];
 gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
 [self configGradientLayer:(CAGradientLayer *)_gradientView.layer];
 
 - (void)configGradientLayer:(CAGradientLayer *)gradient {
 gradient.colors = @[(id)UIColorFromRGB(0x202020).CGColor,(id)UIColorFromRGB(0x191919).CGColor];
 gradient.startPoint = CGPointMake(0, 0);
 gradient.endPoint = CGPointMake(0, 1);
 }
 
 */

#import <UIKit/UIKit.h>

@interface GradientView : UIView

@end
