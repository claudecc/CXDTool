//
//  HMConsoleView.m
//  HuoMao
//
//  Created by claudechoi on 2018/9/11.
//  Copyright © 2018年 claudechoi. All rights reserved.
//

#import "HMConsoleView.h"

@interface HMConsoleView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, assign) BOOL isTextViewMoving;

@property (nonatomic, assign) CGPoint startTouchPoint;

@property (nonatomic, assign) NSInteger lineCount;

@end

@implementation HMConsoleView

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static HMConsoleView *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[HMConsoleView alloc] init];
    });
    return instance;
}

+ (void)insertText:(NSString *)text {
    HMConsoleView *view = [HMConsoleView shareInstance];
    [view insertText:text];
    [view show];
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
        self.lineCount = 1;
    }
    return self;
}

- (void)setupUI {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    [self addSubview:textView];
    self.textView = textView;
    textView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    textView.textColor = [UIColor whiteColor];
    textView.editable = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    tap.delegate = self;
    [textView addGestureRecognizer:tap];
    
}

- (void)insertText:(NSString *)text {
    if (self.lineCount == 1) {
        self.textView.text = [NSString stringWithFormat:@"1 : %@",text];
    } else {
        self.textView.text = [NSString stringWithFormat:@"%@\n%ld : %@",self.textView.text,self.lineCount,text];
    }
//    CGSize contentSize = GetTextSize(self.textView.text, self.textView.font, self.textView.width);
    [self.textView setContentOffset:CGPointMake(0, self.textView.contentSize.height-self.textView.height) animated:YES];
    self.lineCount++;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (CGRectContainsPoint(self.textView.frame, [touch locationInView:self])) { return NO; }
    return YES;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.textView.frame, point)) {
        self.isTextViewMoving = YES;
        self.startTouchPoint = point;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    if (self.isTextViewMoving) {
        CGFloat offsetX = point.x - self.startTouchPoint.x;
        CGFloat offsetY = point.y - self.startTouchPoint.y;
        self.textView.frame = CGRectMake(offsetX, offsetY, self.textView.width, self.textView.height);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isTextViewMoving = NO;
    CGFloat textViewMaxX = self.textView.maxX;
    CGFloat textViewMaxY = self.textView.maxY;
    CGFloat textViewX = (self.textView.x >= 0) ? ((textViewMaxX <= SCREEN_WIDTH) ? :  (SCREEN_WIDTH - self.textView.width)) : 0;
    CGFloat textViewY = (self.textView.y >= 0) ? ((textViewMaxY <= SCREEN_HEIGHT) ? :  (SCREEN_HEIGHT - self.textView.height)) : 0;
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.textView.frame = CGRectMake(textViewX, textViewY, self.textView.width, self.textView.height);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)show {
    [WINDOW addSubview:self];
    
}

- (void)hide {
    [self removeFromSuperview];
}

@end
