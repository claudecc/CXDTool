//
//  MeHeaderView.h
//  CXDTool
//
//  Created by claudechoi on 2018/4/13.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MeHeaderStyle) {
    MeHeaderStyleOne,
    MeHeaderStyleTwo,
    MeHeaderStyleThree,
};

@interface MeHeaderView : UIView

@property (nonatomic, assign) MeHeaderStyle style;

@property (nonatomic,assign) BOOL isAnimating;

@property (nonatomic,assign) CGFloat dropOffsetH;

/** 滚动偏移*/
- (void)scrollWithOffsetY:(CGFloat)offsetY;

/** 结束动画*/
- (void)endingAnimateWithComplete:(void(^)(void))complete;

@end
