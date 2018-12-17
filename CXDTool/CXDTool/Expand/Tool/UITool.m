//
//  UITool.m
//  CXDTool
//
//  Created by claudechoi on 2018/4/3.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "UITool.h"

@implementation UITool

// imageName 图片名字， text 需画的字体
- (UIImage *)createShareImage:(NSString *)imageName Context:(NSString *)text
{
    UIImage *sourceImage = [UIImage imageNamed:imageName];
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    CGFloat nameFont = 20.f;
    //画 自己想要画的内容
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]};
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, nameFont) options:NSStringDrawingUsesDeviceMetrics attributes:attributes context:nil];
    NSLog(@"图片: %f %f",imageSize.width,imageSize.height);
    NSLog(@"sizeToFit: %f %f",sizeToFit.size.width,sizeToFit.size.height);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    [text drawAtPoint:CGPointMake((imageSize.width-sizeToFit.size.width)/2,0) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]}];
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)createImageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    // UIKit实现
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    [color setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)createImageWithSize:(CGSize)size text:(NSString *)text attriDict:(NSDictionary *)attriDict {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    // UIKit实现
    [text drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attriDict];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContextWithOptions(reSize, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    CGSize size = CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (UIFont *)lightFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)regularFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)mediumFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (float)getWidthWithStr:(NSString *)str andFont:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 9999, font.lineHeight)];
    label.text = str;
    label.font = font;
    [label sizeToFit];
    return label.size.width;
}

+ (CGSize)getSizeWithStr:(NSString *)str andFont:(UIFont *)font andMaxW:(CGFloat)maxW
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxW, font.lineHeight)];
    label.text = str;
    label.numberOfLines = 0;
    label.font = font;
    [label sizeToFit];
    return label.size;
}

+ (UIImage *)createHorizontalGradientImageWithSize:(CGSize)size leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.colors = @[(__bridge id)leftColor.CGColor,(__bridge id)rightColor.CGColor];
    layer.locations = @[@(0),@(1)];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+ (UIImage *)createBorderWithSize:(CGSize)size corners:(UIRectCorner)corners {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:corners cornerRadii:CGSizeMake(size.height*0.5, size.height*0.5)];
    
//    bezier.lineWidth = 1;
    [UIColorFromRGB(0xFF4029) set];
    [bezier stroke];
    
    [bezier setLineJoinStyle:kCGLineJoinRound];
    [bezier setLineCapStyle:kCGLineCapRound];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.path = bezier.CGPath;
    layer.fillColor = UIColor.clearColor.CGColor;
//    layer.borderWidth = 1;
//    layer.borderColor = UIColorFromRGB(0xFF4029).CGColor;
//    layer.fillColor = UIColor.clearColor.CGColor;
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

NSString *SafeString(NSString *string)
{
    if (string == nil || string == NULL || ![string isKindOfClass:[NSString class]] || ([string isEqual:@""]) || ([string isEqual:@"(null)"]) || ([string isEqual:@"null"]) || ([string isEqual:@" "]) || ([string isKindOfClass:[NSNull class]])) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",string];
}

+ (void)showToast:(NSString *)text {
    if (!text || SafeString(text).length <= 0) {
        return;
    }
    static NSInteger showtoast_view_tag = 189111554;
    UIView *preView = [WINDOW viewWithTag:showtoast_view_tag];
    if (preView) {
        [preView removeFromSuperview];
    }
    
    UIFont *font = [UIFont pingFangRegularFontWithSize:16];
    CGFloat width = SCREEN_WIDTH*0.8;
    CGSize size = GetTextSize(text, font, width);
    
    UILabel *toastView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width + 10, size.height + 10)];
    toastView.tag = showtoast_view_tag;
    toastView.text = text;
    toastView.font = font;
    toastView.textColor = [UIColor whiteColor];
    toastView.textAlignment = NSTextAlignmentCenter;
    toastView.numberOfLines = 0;
    toastView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    toastView.layer.cornerRadius = 5;
    toastView.layer.masksToBounds = YES;
    toastView.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.5);
    [WINDOW addSubview:toastView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toastView removeFromSuperview];
    });
}

@end
