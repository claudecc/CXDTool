//
//  PictureDisplayView.h
//  CXDTool
//
//  Created by claudechoi on 2018/11/16.
//  Copyright © 2018 claudechoi. All rights reserved.
//

/**
 Five types:
 
 Single picture(max width,max height)
 Three pictures(two,three)
 Four pictures
 Six pictures(five,six)
 nine pictures(seven,eight,nine)
 
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PictureDisplayViewType) {
    PictureDisplayViewTypeSingle,
    PictureDisplayViewTypeThree, // include(2/3)
    PictureDisplayViewTypeFour,
    PictureDisplayViewTypeSix,   // include(5/6)
    PictureDisplayViewTypeNine,  // include(7/8/9)
};

NS_ASSUME_NONNULL_BEGIN

@interface PictureDisplayView : UIView

@property (nonatomic, assign) PictureDisplayViewType type;

@property (nonatomic, strong) NSArray *pictureArray;

@end

NS_ASSUME_NONNULL_END
