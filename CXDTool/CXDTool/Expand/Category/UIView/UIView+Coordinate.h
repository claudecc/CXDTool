//
//  UIView+Coordinate.h
//  CXDTool
//
//  Created by claudechoi on 2018/4/3.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Coordinate)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property CGFloat top;
@property CGFloat left;

@property CGFloat bottom;
@property CGFloat right;

/** 最大 X */
@property (nonatomic, assign) CGFloat maxX;
/** 最大 Y */
@property (nonatomic, assign) CGFloat maxY;

//- (void)setBorderWidth:(CGFloat)bWidth
//           borderColor:(UIColor *)bColor;
//
//- (void)setCornerRadius:(CGFloat)cornerRadius
//            borderWidth:(CGFloat)bWidth
//            borderColor:(UIColor *)bColor;

//+ (instancetype)viewWithBgColor:(UIColor *)bgColor
//                          frame:(CGRect)frame;

///  由子控件获取cell，只是cell的子控件才能调用
- (UITableViewCell *)getTableViewCellIfExsited;

///  创建view
///  由子类实现
+ (instancetype)creatView;

///  从xib中加载和类名一样的xib
+ (instancetype)creatViewFromNib;
///  从xib中加载view
///  @param aName xib名字
///  @param index 在xib数组中的索引
+ (instancetype)creatViewFromNibName:(NSString *)aName atIndex:(NSInteger)index;

@end
