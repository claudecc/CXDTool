//
//  MyTool.m
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "MyTool.h"
#import "AppDelegate.h"
#import "BaseTabbarVC.h"

@implementation MyTool

+ (BOOL)isLogin {
    return YES;
}

+ (NSString *)getStringFromObj:(id)obj {
    if ([obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return obj?[NSString stringWithFormat:@"%@",obj]:@"";
}

// 过滤HTML标签
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

// 找包含 元、单、% 数字的正则
+ (NSRange)findKeyString:(NSString *)content {
    NSString *pattern = @"([0-9]+[0-9\\.]*)[\u5143]+";
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSTextCheckingResult *result = [expression firstMatchInString:content options:0 range:NSMakeRange(0, content.length)];
    NSString *value = [content substringWithRange:[result rangeAtIndex:1]];
    NSRange range = [content rangeOfString:value options:NSBackwardsSearch];
    return range;
}

//时间戳转时间
+(NSString*)timestampSwitchTime:(NSString*)timestamp

{
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timestamp integerValue]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // [dateFormat setDateFormat:@"HH:mm:ss"];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:nd];
    return dateString;
}


/** 区间随机数 */
+ (float)randomBetween:(float)smallerNumber And:(float)largerNumber
{
    //设置精确的位数
    int precision = 100;
    //先取得他们之间的差值
    float subtraction = largerNumber - smallerNumber;
    //取绝对值
    subtraction = ABS(subtraction);
    //乘以精度的位数
    subtraction *= precision;
    //在差值间随机
    float randomNumber = arc4random() % ((int)subtraction+1);
    //随机的结果除以精度的位数
    randomNumber /= precision;
    //将随机的值加到较小的值上
    float result = MIN(smallerNumber, largerNumber) + randomNumber;
    //返回结果
    return result;
}

CGSize GetTextSize(NSString *text, UIFont *font, CGFloat width)
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size;
}

NSInteger GetTabbarCurrentIndex(void) {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BaseTabbarVC *tabbarVC = (BaseTabbarVC *)appDelegate.window.rootViewController;
    if ([tabbarVC isKindOfClass:[BaseTabbarVC class]]) {
        return tabbarVC.selectedIndex;
    }
    return 0;
}

NSInteger GetTabbarIndexWithVC(UIViewController *vc) {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BaseTabbarVC *tabbarVC = (BaseTabbarVC *)appDelegate.window.rootViewController;
    if ([tabbarVC isKindOfClass:[BaseTabbarVC class]]) {
        for (NSInteger i = 0; i < tabbarVC.viewControllers.count; i++) {
            UIViewController *childVC = tabbarVC.viewControllers[i];
            if ([childVC isEqual:vc]) {
                return i;
            }
        }
    }
    return 0;
}

NSInteger GetTabbarCount(void) {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BaseTabbarVC *tabbarVC = (BaseTabbarVC *)appDelegate.window.rootViewController;
    if ([tabbarVC isKindOfClass:[BaseTabbarVC class]]) {
        return tabbarVC.viewControllers.count;
    }
    return 0;
}

@end
