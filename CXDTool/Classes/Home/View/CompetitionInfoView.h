//
//  CompetitionInfoView.h
//  CXDTool
//
//  Created by claudechoi on 2018/8/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CompetitionInfoViewStyle) {
    CompetitionInfoViewStyleScore,
    CompetitionInfoViewStyleTitle,
};

@interface CompetitionInfoView : UIView

@property (nonatomic, assign) CompetitionInfoViewStyle type;

@end

@interface ColonView : UIView

@end
