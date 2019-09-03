//
//  BaseVC.m
//  CXDTool
//
//  Created by claudechoi on 2018/3/29.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "BaseVC.h"

static char *btnClickAction;

@interface BaseVC ()

@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *navRightBtn;

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *naviImage = [UITool createImageWithColor:[UIColor whiteColor] frame:CGRectMake(0, 0, 1, 1)];
    [self.navigationController.navigationBar setBackgroundImage:naviImage forBarMetrics:UIBarMetricsDefault];
    
}

-(void)setLeftButtonWithTitle:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage Action:(void (^)(void))btnClickBlock{
    self.navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    objc_setAssociatedObject(self.navLeftBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self setCustomButton:self.navLeftBtn Title:title Image:image SelectedImage:selectedImage];
    [self.navLeftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
}

-(void)setRightButtonWithTitle:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage Action:(void (^)(void))btnClickBlock{
    self.navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    objc_setAssociatedObject(self.navRightBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self setCustomButton:self.navRightBtn Title:title Image:image SelectedImage:selectedImage];
    [self.navRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
}

-(void)setCustomButton:(UIButton *)button Title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage{
    if (image) {
        [button setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [button setImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
    if (title) {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    //内省
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark ---- ActionBtnClick
- (void)actionBtnClick:(UIButton *)btn {
    void (^btnClickBlock) (void) = objc_getAssociatedObject(btn, &btnClickAction);
    btnClickBlock();
}

@end
