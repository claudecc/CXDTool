//
//  NSString+Tool.h
//  CXDTool
//
//  Created by claudechoi on 2018/4/3.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSStringGetString(str) [MyTool getStringFromObj:str]
#define NSGetAttributeString(str) [[NSMutableAttributedString alloc] initWithString:str]

@interface NSString (Tool)

/** 是否相等 */
@property (nonatomic, copy, readonly) BOOL (^isEqualStr)(NSString *str);
/** 是否有字符串 */
@property (nonatomic, assign, readonly) BOOL hasText;
/** 替换 \\n <br/> <br> 为 \n */
@property (nonatomic, copy, readonly) NSString *formatBreak;
/** 是否包含emoji*/
@property (nonatomic, assign, readonly) BOOL containEmoji;
/** appendingString */
@property (nonatomic, copy, readonly) NSString* (^appendingString)(NSString *str);
/** 是否含有emoji */
@property (nonatomic, assign, readonly) BOOL hasEmoji;
/** 清除emoji */
@property (nonatomic, copy, readonly) NSString *clearEmojiString;
/** 字节长度 */
@property (nonatomic, assign, readonly) int byteLength;
/** 根据字节长度截取 */
@property (nonatomic, copy, readonly) NSString* (^subStringByByteIndex)(NSInteger index);

@end
