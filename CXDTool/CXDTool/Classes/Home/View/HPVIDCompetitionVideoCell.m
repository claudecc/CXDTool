//
//  HPVIDCompetitionVideoCell.m
//  CXDTool
//
//  Created by claudechoi on 2018/8/24.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "HPVIDCompetitionVideoCell.h"

@interface HPVIDCompetitionVideoCell()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation HPVIDCompetitionVideoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *cellId = @"HPVIDCompetitionVideoCellId";
    HPVIDCompetitionVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HPVIDCompetitionVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VideoCellH)];
    [self.contentView addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)setListArray:(NSMutableArray *)listArray {
    _listArray = listArray.mutableCopy;
    
    [self refreshUI];
}

- (void)refreshUI {
    if (!self.listArray || ![self.listArray isKindOfClass:[NSArray class]] || self.listArray.count == 0) {
        return;
    }
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
    for (UIView *subview in self.scrollView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat imageX = 12;
    CGFloat imageY = 8;
    CGFloat imageW = 150;
    CGFloat imageH = 85;
    
    CGFloat iconWH = 11;
    CGFloat iconMargin = 5;
    CGFloat iconY = imageH - iconWH - iconMargin;
    
    CGFloat subLabelW = 50;
    CGFloat subLabelH = 10;
    CGFloat numberX = iconMargin + iconWH + 4;
    CGFloat timeX = imageW - iconMargin - subLabelW;
    
    CGFloat titleY = imageY + imageH + 11;
    
    for (NSInteger i = 0; i < self.listArray.count; i++) {
        NSInteger objNum = [self.listArray[i] integerValue];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        [self.scrollView addSubview:imageView];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
        [imageView addGestureRecognizer:tap];
        imageView.backgroundColor = UIColor.grayColor;
        
        UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:4];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = imageView.bounds;
        layer.path = bezier.CGPath;
        imageView.layer.mask = layer;
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconMargin, iconY, iconWH, iconWH)];
        [imageView addSubview:iconView];
        iconView.backgroundColor = UIColor.orangeColor;
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberX, iconY, subLabelW, subLabelH)];
        [imageView addSubview:numberLabel];
        numberLabel.font = [UIFont systemFontOfSize:10];
        numberLabel.textColor = UIColor.whiteColor;
        numberLabel.text = [NSString stringWithFormat:@"%2ld万",objNum];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, iconY, subLabelW, subLabelH)];
        [imageView addSubview:timeLabel];
        timeLabel.font = [UIFont systemFontOfSize:10];
        timeLabel.textColor = UIColor.whiteColor;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.text = @"01:24";
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageX, titleY, imageW, 13)];
        [self.scrollView addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = UIColorFromRGB(0x333333);
        titleLabel.text = @"高校联赛-扎心老男孩";
        
        imageX = imageView.maxX + 12;
    }
    
    self.scrollView.contentSize = CGSizeMake(imageX, self.scrollView.height);
}

- (void)imageTapAction:(UITapGestureRecognizer *)tap {
    UIView *tapView = tap.view;
    NSInteger index = tapView.tag;
    if (index == 0) {
        return;
    }
    
    if (index < self.listArray.count) {
        NSObject *obj = self.listArray[index];
        [self.listArray removeObjectAtIndex:index];
        [self.listArray insertObject:obj atIndex:0];
        
        [self refreshUI];
    }
}

@end
