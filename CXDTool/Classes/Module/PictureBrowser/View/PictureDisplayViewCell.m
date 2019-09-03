//
//  PictureDisplayViewCell.m
//  CXDTool
//
//  Created by claudechoi on 2018/11/16.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "PictureDisplayViewCell.h"

@interface PictureDisplayViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation PictureDisplayViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    self.layer.mask = maskLayer;
    self.maskLayer = maskLayer;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect))];
    self.maskLayer.frame = rect;
    self.maskLayer.path = bezierPath.CGPath;
}

@end
