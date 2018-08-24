//
//  HPVIDCompetitionVideoCell.h
//  CXDTool
//
//  Created by claudechoi on 2018/8/24.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VideoCellH 136

@interface HPVIDCompetitionVideoCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *listArray;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
