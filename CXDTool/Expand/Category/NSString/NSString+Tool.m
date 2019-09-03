//
//  NSString+Tool.m
//  CXDTool
//
//  Created by claudechoi on 2018/4/3.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)

- (BOOL (^)(NSString *))isEqualStr {
    BOOL(^block)(NSString *) = ^(NSString *str) {
        if ([self isEqualToString:str]) {
            return YES;
        }
        return NO;
    };
    return block;
}

- (BOOL)hasText {
    if (self.length > 0) {
        return YES;
    }
    return NO;
}

- (NSString *)formatBreak {
    NSString *str = self;
    NSString *tempStr = @"\\n";
    if ([self containsString:tempStr]) {
        str = [str stringByReplacingOccurrencesOfString:tempStr withString:@"\n"];
    }
    tempStr = @"<br/>";
    if ([self containsString:tempStr]) {
        str = [str stringByReplacingOccurrencesOfString:tempStr withString:@"\n"];
    }
    tempStr = @"<br>";
    if ([self containsString:tempStr]) {
        str = [str stringByReplacingOccurrencesOfString:tempStr withString:@"\n"];
    }
    return str;
}

- (BOOL)containEmoji {
    NSString *string = self;
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

- (NSString *(^)(NSString *))appendingString {
    NSString *(^block)(NSString *) = ^(NSString *appendingStr){
        NSString *str = [self stringByAppendingString:appendingStr];
        return str;
    };
    return block;
}

- (BOOL)hasEmoji
{
    NSString *text = self;
    NSInteger length = text.length;
    if (length <= 0) {
        return NO;
    }
    
    NSString *modifiedString = [self removeEmojiString:text];
    if (modifiedString && modifiedString.length > 0) {
        if (modifiedString.length == length) { // 与原本的长度一样，表示没有emoji
            return NO;
        }
    }
    return YES;
}

- (NSString *)clearEmojiString {
    NSString *text = self;
    
    NSString *modifiedString = [self removeEmojiString:text];
    if (modifiedString && modifiedString.length > 0) {
        return modifiedString;
    }
    return @"";
}

- (NSString *)removeEmojiString:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, text.length) withTemplate:@""];
    return modifiedString;
}

-  (int)byteLength {
    NSString *strtemp = self;
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (NSString *(^)(NSInteger))subStringByByteIndex {
    NSString *(^block)(NSInteger) = ^(NSInteger index){
        NSInteger sum = 0;
        NSString *subStr = [[NSString alloc] init];
        for(int i = 0; i<[self length]; i++){
            NSRange rangeIndex = [self rangeOfComposedCharacterSequenceAtIndex:i];
            unichar strChar = [self characterAtIndex:i];
            if (strChar < 256) {
                sum += 1;
            } else {
                sum += 2;
            }
            if (sum >= index) {
                NSInteger moreIndex = 1;
                if (rangeIndex.length > 1) {
                    moreIndex = rangeIndex.length;
                }
                subStr = [self substringToIndex:i+moreIndex];
                return subStr;
            }
        }
        return subStr;
    };
    return block;
}

@end
