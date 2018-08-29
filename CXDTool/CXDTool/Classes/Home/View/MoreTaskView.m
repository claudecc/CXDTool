//
//  MoreTaskView.m
//  CXDTool
//
//  Created by 蔡晓东 on 2018/8/30.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "MoreTaskView.h"

@interface MoreTaskView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation MoreTaskView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupUI {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    CGFloat bgH = 300;
    CGFloat bgY = self.height - bgH;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, bgY, self.width, bgH)];
    [self addSubview:bgView];
    bgView.backgroundColor = UIColor.whiteColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:bgView.bounds];
    [bgView addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    NSInteger page = 0;
    CGFloat pageW = bgView.width;
    CGFloat btnW = pageW / 4.0;
    CGFloat btnH = 90;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < 20; i++) {
        if (i != 0 && i%4 == 0) {
            btnY += btnH;
        }
        if (i != 0 && i%8 == 0) {
            page++;
            btnY = 0;
        }
        btnX = (i%4)*btnW + page*pageW;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        [scrollView addSubview:button];
        button.backgroundColor = randomColor;
        
    }
    scrollView.contentSize = CGSizeMake((page+1)*pageW, scrollView.height);
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollView.height - 40, scrollView.width, 40)];
    [bgView addSubview:pageControl];
    self.pageControl = pageControl;
    pageControl.hidesForSinglePage = YES;
    pageControl.numberOfPages = page+1;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = UIColor.lightGrayColor;
    pageControl.currentPageIndicatorTintColor = UIColor.blackColor;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.width;
}

- (void)show {
    [WINDOW addSubview:self];
}

- (void)hide {
    [self removeFromSuperview];
}

@end
