//
//  BasicMacro.h
//  CXDTool
//
//  Created by claudechoi on 2018/4/28.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#ifndef BasicMacro_h
#define BasicMacro_h


#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

// 引用
#define XDWeakSelf __weak typeof(&*self) weakSelf = self;
#define XDStrongSelf(_ref) __strong typeof(&*self) strongSelf = _ref;

#define WINDOW [UIApplication sharedApplication].keyWindow

#endif /* BasicMacro_h */
