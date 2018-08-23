//
//  CompetitionCommentatorView.m
//  CXDTool
//
//  Created by claudechoi on 2018/8/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "CompetitionCommentatorView.h"

@interface CompetitionCommentatorView()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CompetitionCommentatorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 64)];
    [self addSubview:leftIcon];
    //    leftIcon.image
    leftIcon.backgroundColor = UIColor.redColor;
    
    CGFloat tableW = CGRectGetWidth(self.frame) - 46;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(46, 0, tableW, 64)];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.scrollsToTop = NO;
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 12);
    scrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat btnW = 148;
    CGFloat btnH = 64;
    CGFloat btnX = 0;
    for (NSInteger i = 0; i < 10; i++) {
        CompetitionCommentatorButton *button = [[CompetitionCommentatorButton alloc] initWithFrame:CGRectMake(btnX, 0, btnW, btnH)];
        [scrollView addSubview:button];
        btnX = CGRectGetMaxX(button.frame) + 12;
        button.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        button.layer.cornerRadius = 2;
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.userLabel.text = [NSString stringWithFormat:@"第%ld条",i];
        if (i == 9) {
            scrollView.contentSize = CGSizeMake(button.maxX, 64);
        }
    }
    
}

- (void)buttonClickAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    for (UIButton *button in self.scrollView.subviews) {
        if (![button isKindOfClass:[UIButton class]]) {
            continue;
        }
        if (button == sender) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
}

@end

@implementation CompetitionCommentatorButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat iconWH = 50;
    CGFloat iconY = (CGRectGetHeight(self.frame) - iconWH)*0.5;
    UIImageView *userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(6, iconY, iconWH, iconWH)];
    [self addSubview:userIcon];
    self.userIcon = userIcon;
    userIcon.backgroundColor = UIColor.orangeColor;
    
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:userIcon.bounds cornerRadius:iconWH*0.5];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = userIcon.bounds;
    layer.path = bezier.CGPath;
    userIcon.layer.mask = layer;
    
    UIView *iconShapeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconWH+4, iconWH+4)];
    [self insertSubview:iconShapeView belowSubview:userIcon];
    iconShapeView.center = userIcon.center;
    iconShapeView.backgroundColor = UIColorFromRGB(0xE1E1E1);
    iconShapeView.layer.cornerRadius = iconShapeView.height*0.5;
    
    CGFloat labelX = CGRectGetMaxX(userIcon.frame) + 10;
    CGFloat labelW = CGRectGetWidth(self.frame) - labelX - 10;
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 0, labelW, self.height)];
    [self addSubview:userLabel];
    self.userLabel = userLabel;
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.numberOfLines = 2;
    userLabel.font = [UIFont systemFontOfSize:14];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.userLabel.textColor = UIColorFromRGB(0xFC4C26);
    } else {
        self.userLabel.textColor = UIColorFromRGB(0x333333);
    }
}

@end
