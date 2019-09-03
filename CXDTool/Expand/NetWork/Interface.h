//
//  Interface.h
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    GET,
    POST,
};

@interface Interface : NSObject

+ (instancetype)shareInstance;

+ (void)requestWithUrl:(NSString *)url
               baseUrl:(NSString *)baseUrl
                method:(HTTPMethod)method
            parameters:(id)parameters
              complete:(void (^)(BOOL isSuccess,NSString *code,NSString *msg,NSObject *result))complete;

@end
