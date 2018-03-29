//
//  MyTool.m
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "MyTool.h"

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

@end
