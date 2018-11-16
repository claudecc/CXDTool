//
//  PictureDisplayView.m
//  CXDTool
//
//  Created by claudechoi on 2018/11/16.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "PictureDisplayView.h"
#import "PictureDisplayViewCell.h"

@implementation PictureDisplayView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = UIColor.lightGrayColor;
    
}

- (void)setSinglePictureUI {
    
}



#pragma mark - event

- (void)tapPictureAction:(UITapGestureRecognizer *)tap {
    PictureDisplayViewCell *picture = (PictureDisplayViewCell *)tap.view;
    
}

@end
