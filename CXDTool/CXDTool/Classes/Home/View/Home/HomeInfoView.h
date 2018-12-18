//
//  HomeInfoView.h
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeDelegate.h"

typedef NS_ENUM(NSUInteger, HomeInfoViewEvent) {
    HomeInfoViewEventClick,
};

@protocol HomeInfoViewDelegate;
@interface HomeInfoView : UIView

@property (nonatomic, weak) id<HomeInfoViewDelegate> delegate;

@end

@protocol HomeInfoViewDelegate <NSObject>

- (void)testSelector;

@end
