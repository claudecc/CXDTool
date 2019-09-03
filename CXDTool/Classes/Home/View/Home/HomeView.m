//
//  HomeView.m
//  CXDTool
//
//  Created by claudechoi on 2018/12/17.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "HomeView.h"
#import "HomeInfoView.h"
#import "HomeEventManager.h"

@interface HomeView ()<UIGestureRecognizerDelegate,HomeInfoViewDelegate>

@property (nonatomic, strong) HomeInfoView *infoView;

@end

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupUI {
    HomeInfoView *view = [[HomeInfoView alloc] initWithFrame:CGRectMake(40, 40, 200, 200)];
    [self addSubview:view];
    self.infoView = view;
    view.delegate = self;
}

- (void)testSelector {
    [HomeEventManager actionObj:self.infoView moduleType:HomeEventModuleTypeHomeView objEvent:HomeInfoViewEventClick message:@"info点击"];
}

- (void)hide {
    [self removeFromSuperview];
}

- (void)controller:(HomeVC *)controller vcEvent:(HomeEventVcEvent)vcEvent message:(id)message {
    NSString *text = (NSString *)message;
    [UITool showToast:SafeString(text)];

}

@end
