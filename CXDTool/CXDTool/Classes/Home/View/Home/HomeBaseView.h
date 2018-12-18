//
//  HomeBaseView.h
//  CXDTool
//
//  Created by claudechoi on 2018/12/18.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeVC;
@interface HomeBaseView : UIView<HomeEventVCToViewDelegate>
{
    @public
    struct {
        unsigned int homePublicDelegate : 1;
    } _delegateRespondsTo;
}

@end

