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
    leftIcon.image = [self createViewWithFrame:leftIcon.frame];
//    UILabel *iconLabel = [[UILabel alloc] initWithFrame:leftIcon.bounds];
//    [leftIcon addSubview:iconLabel];
//    iconLabel.text = @"解\n说\n切\n换";
//    iconLabel.font = [UITool mediumFontWithSize:10];
//    iconLabel.textColor = UIColor.whiteColor;
//    iconLabel.numberOfLines = 0;
//    [iconLabel sizeToFit];
//    iconLabel.center = CGPointMake(leftIcon.centerX - 2, leftIcon.centerY);
    
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

- (UIImage *)createViewWithFrame:(CGRect)frame {
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    CGFloat triangleH = 4;
    CGFloat triangleW = 10;
    CGFloat radius = 2;
    CGPoint topCenter = CGPointMake(width-triangleH - radius, radius);
    CGPoint bottomCenter = CGPointMake(topCenter.x, height-radius);
    CGFloat rightX = width - triangleH;
    
    // 获取图片上下文
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    // 绘图
    UIBezierPath* bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointZero];
    [bezier addLineToPoint:CGPointMake(topCenter.x, 0)];
    [bezier addArcWithCenter:topCenter radius:radius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    [bezier addLineToPoint:CGPointMake(rightX, (height-triangleW)*0.5)];
    [bezier addLineToPoint:CGPointMake(width, height*0.5)];
    [bezier addLineToPoint:CGPointMake(rightX, (height-triangleW)*0.5+triangleW)];
    [bezier addLineToPoint:CGPointMake(rightX, bottomCenter.y)];
    [bezier addArcWithCenter:bottomCenter radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [bezier addLineToPoint:CGPointMake(0, height)];
    [bezier addLineToPoint:CGPointZero];
    
    [UIColorFromRGB(0xFC4C26) setFill];
    [bezier fill];
    
    NSString *string = @"解说切换";
    
//    NSParagraphStyleAttributeName
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.maximumLineHeight = 0;
    
    
    UIFont *font = [UITool mediumFontWithSize:12];
    NSDictionary *dict  = @{NSFontAttributeName:font,
                 NSForegroundColorAttributeName:UIColor.whiteColor,
                  NSParagraphStyleAttributeName:style,
                  NSBaselineOffsetAttributeName:@(1)
                            };
//    [string drawInRect:CGRectMake(0, 0, width, height)withFont:font lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    
    [string drawInRect:CGRectMake(0, 0, width, height) withAttributes:dict];
    
    // 从图片上下文中获取绘制的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图片上下文
    UIGraphicsEndImageContext();
    return image;
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
