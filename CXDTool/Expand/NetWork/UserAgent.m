//
//  UserAgent.m
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "UserAgent.h"
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>

@implementation UserAgent

static UserAgent *instance = nil;
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [UserAgent new];
    });
    return instance;
}

- (NSString *)getUserAgent{
    
    // 这个是版本号
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    version = [version stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 这个是手机系统号
    NSString *platVersion = [[UIDevice currentDevice] systemVersion];
    
    // 这个是  userid
    NSString *uid = @"0";
    
    // 设备的唯一标识
    NSString *uuid = [self p_idfa];
    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    // 这一步是手机号
    NSString *phoneNumber = @"0";
    
    // 这是最终结果
    NSString *customUserAgent = [NSString stringWithFormat:@"protocol://%@(iOS;iOS%@;zh_CN;ID:1-%@-%@-AppStore-%@)", version, platVersion, uid, uuid, phoneNumber];
    
    return customUserAgent;
}

#pragma mark ----  idfa
-(NSString *)p_idfa{
    NSString *idfaStr;
    Class theClass=NSClassFromString(@"ASIdentifierManager");
    if (theClass)
    {
        idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else{
        idfaStr = @"";
    }
    return idfaStr;
}

@end
