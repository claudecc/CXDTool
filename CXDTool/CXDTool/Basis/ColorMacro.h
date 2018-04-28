//
//  ColorMacro.h
//  CXDTool
//
//  Created by claudechoi on 2018/4/28.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#ifndef ColorMacro_h
#define ColorMacro_h

// RGB
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// RGBA
#define AlphaColorWithRGBA(_rgbValue_, _alpha_) [UIColor \
colorWithRed:((float)((_rgbValue_ & 0xFF0000) >> 16))/255.0 \
green:((float)((_rgbValue_ & 0xFF00) >> 8))/255.0 \
blue:((float)(_rgbValue_ & 0xFF))/255.0 alpha:_alpha_]


#endif /* ColorMacro_h */
