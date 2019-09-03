//
//  CompetitionInfoView.m
//  CXDTool
//
//  Created by claudechoi on 2018/8/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "CompetitionInfoView.h"

@implementation CompetitionInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = UIColor.whiteColor;
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 100, 17)];
    [self addSubview:timeLabel];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = UIColorFromRGB(0x666666);
    timeLabel.text = @"6月23日 13:30 已结束";
    [timeLabel sizeToFit];
    timeLabel.centerX = self.width*0.5;
    
    CGFloat iconY = CGRectGetMaxY(timeLabel.frame) + 38;
    CGFloat iconWH = 12;
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, iconY, iconWH, iconWH)];
    [self addSubview:iconView];
    iconView.backgroundColor = UIColor.orangeColor;
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconY, 100, 17)];
    [self addSubview:subTitleLabel];
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.textColor = UIColorFromRGB(0x666666);
    subTitleLabel.text = @"TI8国际邀请赛";
    [subTitleLabel sizeToFit];
    subTitleLabel.centerX = self.width*0.5 + (iconWH + 6)*0.5 ;
    iconView.x = subTitleLabel.x - iconWH - 6;
    iconView.centerY = subTitleLabel.centerY;
}

- (void)setType:(CompetitionInfoViewStyle)type {
    switch (type) {
        case CompetitionInfoViewStyleTitle:
        {
            [self createTitle];
            break;
        }
        case CompetitionInfoViewStyleScore:
        {
            [self createTeamInfo];
            break;
        }
        default:
            break;
    }
}

- (void)createTitle {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 51, 100, 22)];
    [self addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = UIColorFromRGB(0x333333);
    titleLabel.text = @"特别赛事鸡战场《绝地求生》";
    [titleLabel sizeToFit];
    titleLabel.centerX = self.width*0.5;
}

- (void)createTeamInfo {
    CGFloat iconY = 22;
    CGFloat iconWH = 50;
    CGFloat textPadding = 5;
    CGFloat margin = 20;
    CGFloat labelH = 20;
    UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(margin, iconY, iconWH, iconWH)];
    [self addSubview:leftIcon];
    //    leftIcon.image
    leftIcon.backgroundColor = UIColor.orangeColor;
    
    CGFloat labelW = CGRectGetMidX(leftIcon.frame)*2;
    CGFloat labelY = CGRectGetMaxX(leftIcon.frame) + textPadding;
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, labelY, labelW, labelH)];
    [self addSubview:leftLabel];
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = UIColorFromRGB(0x333333);
    leftLabel.text = @"EDG";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat rightIconX = CGRectGetWidth(self.frame) - iconWH - margin;
    UIImageView *rightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(rightIconX, iconY, iconWH, iconWH)];
    [self addSubview:rightIcon];
    //    rightIcon.image
    rightIcon.backgroundColor = UIColor.orangeColor;
    
    CGFloat rightLabelX = CGRectGetWidth(self.frame) - labelW;
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(rightLabelX, labelY, labelW, labelH)];
    [self addSubview:rightLabel];
    rightLabel.font = [UIFont systemFontOfSize:14];
    rightLabel.textColor = UIColorFromRGB(0x333333);
    rightLabel.text = @"GRX";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    
    // score
    CGFloat scoreY = 46;
    CGFloat scoreH = 33;
    CGFloat scoreW = 78;
    ColonView *middleScore = [[ColonView alloc] initWithFrame:CGRectMake(0, scoreY, 10, scoreH)];
    [self addSubview:middleScore];
    middleScore.centerX = self.width*0.5;
    
    CGFloat leftScoreX = middleScore.x - scoreW;
    UILabel *leftScore = [[UILabel alloc] initWithFrame:CGRectMake(leftScoreX, scoreY, scoreW, scoreH)];
    [self addSubview:leftScore];
    leftScore.font = [UIFont systemFontOfSize:24];
    leftScore.textColor = UIColorFromRGB(0x333333);
    leftScore.textAlignment = NSTextAlignmentCenter;
    leftScore.text = @"1";
    
    UILabel *rightScore = [[UILabel alloc] initWithFrame:CGRectMake(middleScore.maxX, scoreY, scoreW, scoreH)];
    [self addSubview:rightScore];
    rightScore.font = [UIFont systemFontOfSize:24];
    rightScore.textColor = UIColorFromRGB(0x333333);
    rightScore.textAlignment = NSTextAlignmentCenter;
    rightScore.text = @"2";
}

@end

@implementation ColonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGFloat w = 3;
    CGFloat padding = 2;
    CGFloat centerX = width * 0.5;
    CGFloat centerY = height*0.5 - w*0.5 - padding;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddArc(context, centerX, centerY, w*0.5, 0, 2*M_PI, 0);
    centerY = rect.size.height - centerY;
    CGContextAddArc(context, centerX, centerY, w*0.5, 0, 2*M_PI, 0);
    
    CGContextDrawPath(context, kCGPathFill);
}

@end
