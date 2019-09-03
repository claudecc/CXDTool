//
//  UITool.h
//  CXDTool
//
//  Created by claudechoi on 2018/4/3.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITool : NSObject

- (UIImage *)createShareImage:(NSString *)imageName Context:(NSString *)text;

+ (UIImage *)createImageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)createImageWithSize:(CGSize)size text:(NSString *)text attriDict:(NSDictionary *)attriDict;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

+ (UIFont *)lightFontWithSize:(CGFloat)size;

+ (UIFont *)regularFontWithSize:(CGFloat)size;

+ (UIFont *)mediumFontWithSize:(CGFloat)size;

+ (float)getWidthWithStr:(NSString *)str andFont:(UIFont *)font;

+ (CGSize)getSizeWithStr:(NSString *)str andFont:(UIFont *)font andMaxW:(CGFloat)maxW;

+ (UIImage *)createHorizontalGradientImageWithSize:(CGSize)size leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor;

+ (UIImage *)createBorderWithSize:(CGSize)size corners:(UIRectCorner)corners;

NSString *SafeString(NSString *string);

+ (void)showToast:(NSString *)text;

+ (UIImage *)createImageWithColor:(UIColor *)color frame:(CGRect)rect;

@end
