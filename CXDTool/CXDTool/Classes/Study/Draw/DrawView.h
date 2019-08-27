//
//  DrawView.h
//  CXDTool
//
//  Created by 蔡晓东 on 2019/8/11.
//  Copyright © 2019 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    CGFloat value;
    UIColor *color;
}AnnulusStruct;

CG_INLINE AnnulusStruct
AnnulusMake(CGFloat value,UIColor *color) {
    AnnulusStruct annulus;
    annulus.value = value;
    annulus.color = color;
    return annulus;
}

@interface DrawView : UIView

- (void)drawAnnulusWithList:(NSArray<NSValue *> *)list;

@end
/*
 //结构体转换成对象
 MyStruce struce = MyStruceMake("name", "address", 123);
 NSValue *value = [NSValue valueWithBytes:&struce objCType:@encode(MyStruce)];
 
 // 对象转结构体
 MyStruce struceBack;
 [array[0] getValue:&struceBack];
 */
