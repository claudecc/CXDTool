//
//  BaseVC.h
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

-(void)setLeftButtonWithTitle:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage Action:(void(^)(void))btnClickBlock;
-(void)setRightButtonWithTitle:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage Action:(void(^)(void))btnClickBlock;

@end
