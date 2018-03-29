//
//  UserAgent.h
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAgent : NSObject

+ (instancetype)shareInstance;

- (NSString *)getUserAgent;

@end
