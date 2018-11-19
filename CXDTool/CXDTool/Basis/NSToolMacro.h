//
//  NSToolMacro.h
//  CXDTool
//
//  Created by claudechoi on 2018/11/19.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#ifndef NSToolMacro_h
#define NSToolMacro_h


/** 数组是否为空 */
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ![_ref isKindOfClass:[NSArray class]] || ([(_ref) count] == 0))

/** 字符串是否为空 */
#define IsStrEmpty(_ref)    ((_ref == nil || _ref == NULL)||![_ref isKindOfClass:[NSString class]]||([_ref isEqual:@""])||([_ref isEqual:@"(null)"])||([_ref isEqual:@"null"])||([_ref isEqual:@" "])||([_ref isKindOfClass:[NSNull class]]))


#endif /* NSToolMacro_h */
