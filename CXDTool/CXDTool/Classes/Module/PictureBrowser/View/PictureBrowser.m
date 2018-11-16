//
//  PictureBrowser.m
//  CXDTool
//
//  Created by claudechoi on 2018/11/16.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "PictureBrowser.h"
#import "PictureBrowserCell.h"
#import "PictureBrowserModel.h"

@interface PictureBrowser ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end


@implementation PictureBrowser

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
    self.backgroundColor = UIColor.blackColor;
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40.f);
        make.bottom.equalTo(self).offset(-50.f);
    }];
}

- (void)tapPictureAction:(UITapGestureRecognizer *)tap {
    
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = UIColor.grayColor;
        _pageControl.currentPageIndicatorTintColor = UIColor.whiteColor;
    }
    return _pageControl;
}

@end
