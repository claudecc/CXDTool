//
//  PictureDisplayView.m
//  CXDTool
//
//  Created by claudechoi on 2018/11/16.
//  Copyright © 2018 claudechoi. All rights reserved.
//

#import "PictureDisplayView.h"
#import "PictureDisplayViewCell.h"

@interface PictureDisplayView ()

@property (nonatomic, assign) CGFloat picturePadding;

@end

@implementation PictureDisplayView

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
    self.backgroundColor = UIColor.lightGrayColor;
    self.picturePadding = 10;
}

- (void)setPictureArray:(NSArray *)pictureArray {
    _pictureArray = pictureArray;
    
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    if (IsArrEmpty(pictureArray)) {
        return;
    }
    
    switch (pictureArray.count) {
        case 1:
        {
            [self setSinglePictureUI];
        }
            break;
        case 2:
        case 3:
        {
            [self setThreePicturesUI];
        }
            break;
        case 4:
        {
            [self setFourPicturesUI];
        }
            break;
        case 5:
        case 6:
        {
            [self setSixPicturesUI];
        }
            break;
        case 7:
        case 8:
        case 9:
        {
            [self setNinePicturesUI];
        }
            break;
        default:
        {
            if (pictureArray.count > 9) {
                [self setNinePicturesUI];
            }
        }
            break;
    }
}

// 1
- (void)setSinglePictureUI {
    
    // It should update layout when image downloaded.
    NSString *imageUrl = SafeString(self.pictureArray.firstObject);
    NSURL *url = [NSURL URLWithString:imageUrl];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        if (image) {
            PictureDisplayViewCell *picture = [[PictureDisplayViewCell alloc] init];
            [self addSubview:picture];
            picture.image = image;
            
            CGFloat imageW = image.size.width;
            CGFloat imageH = image.size.height;
            CGFloat scale = imageW * 1.f / imageH;
            CGFloat maxWHScale = 0.7;
            if (imageW == imageH) { // square, max width height
                [picture mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.bottom.equalTo(self);
                    make.width.height.mas_equalTo(self.mas_width).multipliedBy(maxWHScale);
                }];
            } else if (imageW > imageH) { // max width
                [picture mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.bottom.equalTo(self);
                    make.width.mas_equalTo(self.mas_width).multipliedBy(maxWHScale);
                    make.height.mas_equalTo(self.mas_width).multipliedBy(maxWHScale / scale);
                }];
            } else { // max height
                [picture mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.bottom.equalTo(self);
                    make.width.mas_equalTo(self.mas_width).multipliedBy(maxWHScale * scale);
                    make.height.mas_equalTo(self.mas_width).multipliedBy(maxWHScale);
                }];
            }
            
            [self updateLayout];
        }
    }];
}
// 2~3
- (void)setThreePicturesUI {
    
    PictureDisplayViewCell *lastPicture = nil;
    for (NSString *imageUrl in self.pictureArray) {
        PictureDisplayViewCell *picture = [[PictureDisplayViewCell alloc] init];
        [self addSubview:picture];
        
        [picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.width.height.equalTo(self.mas_width).offset(-2*self.picturePadding).multipliedBy(1/3.0);
            if (lastPicture) {
                make.left.equalTo(lastPicture.mas_right).offset(self.picturePadding);
            } else {
                make.left.equalTo(self);
            }
        }];
        
        NSURL *url = [NSURL URLWithString:SafeString(imageUrl)];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                picture.image = image;
            }
        }];
        
        lastPicture = picture;
    }
    
    [self updateLayout];
    
}
// 4
- (void)setFourPicturesUI {
    
    PictureDisplayViewCell *lastPicture = nil;
    for (NSInteger i = 0;i < self.pictureArray.count ;i++) {
        NSString *imageUrl = self.pictureArray[i];
        BOOL isLine1 = i < 2;
        BOOL isList1 = i%2 == 0;
        BOOL isLast = i == 3;
        
        PictureDisplayViewCell *picture = [[PictureDisplayViewCell alloc] init];
        [self addSubview:picture];
        
        [picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.mas_width).offset(-2*self.picturePadding).multipliedBy(1/3.0);
            if (isLine1) {
                make.top.equalTo(self);
            } else {
                if (isList1) {
                    make.top.equalTo(lastPicture.mas_bottom).offset(self.picturePadding);
                } else {
                    make.top.equalTo(lastPicture);
                }
            }
            if (isList1) {
                make.left.equalTo(self);
            } else {
                make.left.equalTo(lastPicture.mas_right).offset(self.picturePadding);
            }
            if (isLast) {
                make.bottom.equalTo(self);
            }
        }];
        
        NSURL *url = [NSURL URLWithString:SafeString(imageUrl)];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                picture.image = image;
            }
        }];
        
        lastPicture = picture;
    }
    
    [self updateLayout];
    
}
// 5~6
- (void)setSixPicturesUI {
    
    PictureDisplayViewCell *lastPicture = nil;
    for (NSInteger i = 0;i < self.pictureArray.count ;i++) {
        NSString *imageUrl = self.pictureArray[i];
        BOOL isLine1 = i < 3;
        BOOL isList1 = i%3 == 0;
        BOOL isLast = (i == (self.pictureArray.count - 1));
        
        PictureDisplayViewCell *picture = [[PictureDisplayViewCell alloc] init];
        [self addSubview:picture];
        
        [picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.mas_width).offset(-2*self.picturePadding).multipliedBy(1/3.0);
            if (isLine1) {
                make.top.equalTo(self);
            } else {
                if (isList1) {
                    make.top.equalTo(lastPicture.mas_bottom).offset(self.picturePadding);
                } else {
                    make.top.equalTo(lastPicture);
                }
            }
            if (isList1) {
                make.left.equalTo(self);
            } else {
                make.left.equalTo(lastPicture.mas_right).offset(self.picturePadding);
            }
            if (isLast) {
                make.bottom.equalTo(self);
            }
        }];
        
        NSURL *url = [NSURL URLWithString:SafeString(imageUrl)];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                picture.image = image;
            }
        }];
        
        lastPicture = picture;
    }
    
    [self updateLayout];
    
}
// 7~9
- (void)setNinePicturesUI {
    
    PictureDisplayViewCell *lastPicture = nil;
    for (NSInteger i = 0;i < self.pictureArray.count ;i++) {
        NSString *imageUrl = self.pictureArray[i];
        BOOL isLine1 = i < 3;
        BOOL isList1 = i%3 == 0;
        BOOL isLast = (i == (self.pictureArray.count - 1));
        
        PictureDisplayViewCell *picture = [[PictureDisplayViewCell alloc] init];
        [self addSubview:picture];
        
        [picture mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.mas_width).offset(-2*self.picturePadding).multipliedBy(1/3.0);
            if (isLine1) {
                make.top.equalTo(self);
            } else {
                if (isList1) {
                    make.top.equalTo(lastPicture.mas_bottom).offset(self.picturePadding);
                } else {
                    make.top.equalTo(lastPicture);
                }
            }
            if (isList1) {
                make.left.equalTo(self);
            } else {
                make.left.equalTo(lastPicture.mas_right).offset(self.picturePadding);
            }
            if (isLast) {
                make.bottom.equalTo(self);
            }
        }];
        
        NSURL *url = [NSURL URLWithString:SafeString(imageUrl)];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                picture.image = image;
            }
        }];
        
        lastPicture = picture;
    }
    
    [self updateLayout];
    
}

- (void)updateLayout {
    // supview should re layout
    
}

#pragma mark - event

- (void)tapPictureAction:(UITapGestureRecognizer *)tap {
//    PictureDisplayViewCell *picture = (PictureDisplayViewCell *)tap.view;
    
}

@end
