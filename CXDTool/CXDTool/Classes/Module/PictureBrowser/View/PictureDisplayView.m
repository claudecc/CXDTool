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

- (void)setPictureArray:(NSArray *)pictureArray {
    _pictureArray = pictureArray;
    
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    if (IsArrEmpty(pictureArray)) {
        return;
    }
    
    switch (pictureArray.count) {
        case 1:
        {
            [self setSinglePictureUI];
        }
            break;
        case 2:
        case 3:
        {
            [self setThreePicturesUI];
        }
            break;
        case 4:
        {
            [self setFourPicturesUI];
        }
            break;
        case 5:
        case 6:
        {
            [self setSixPicturesUI];
        }
            break;
        case 7:
        case 8:
        case 9:
        {
            [self setNinePicturesUI];
        }
            break;
        default:
        {
            if (pictureArray.count > 9) {
                [self setNinePicturesUI];
            }
        }
            break;
    }
}
/**
 note:
 最大宽高受限父视图
 
 */

// 1
- (void)setSinglePictureUI {
    
    // max width
    
    // max height
    
}
// 2~3
- (void)setThreePicturesUI {
    
}
// 4
- (void)setFourPicturesUI {
    
}
// 5~6
- (void)setSixPicturesUI {
    
}
// 7~9
- (void)setNinePicturesUI {
    
}

#pragma mark - event

- (void)tapPictureAction:(UITapGestureRecognizer *)tap {
    PictureDisplayViewCell *picture = (PictureDisplayViewCell *)tap.view;
    
}

@end
