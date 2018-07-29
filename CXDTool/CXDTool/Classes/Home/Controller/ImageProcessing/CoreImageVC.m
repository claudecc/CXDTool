//
//  CoreImageVC.m
//  CXDTool
//
//  Created by 蔡晓东 on 2018/7/23.
//  Copyright © 2018年 claudechoi. All rights reserved.
//
/**
 stage_photo
 tumblr_hairstyles.jpg
 */
#import "CoreImageVC.h"
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>

@interface CoreImageVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *filterView;

@end

@implementation CoreImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self setupUI];
    
}

- (void)config {
    // 相册访问权限
    PHAuthorizationStatus albumStatus = [PHPhotoLibrary authorizationStatus];
    if (albumStatus == PHAuthorizationStatusRestricted || albumStatus == PHAuthorizationStatusDenied)
    {
        // 无权限
        // do something...
    }
    
    // 相机访问权限
    AVAuthorizationStatus cameraStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (cameraStatus == AVAuthorizationStatusRestricted || cameraStatus == AVAuthorizationStatusDenied)
    {
        // 无权限
        // do something...
    }
    
}

- (void)setupUI {
    XDWeakSelf
    [self setRightButtonWithTitle:@"添加图片" Image:nil SelectedImage:nil Action:^{
        [weakSelf popImageSelection];
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 88, 200, 200)];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.layer.masksToBounds = YES;
    
    UIImageView *filterView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 300, 200, 200)];
    [self.view addSubview:filterView];
    self.filterView = filterView;
    filterView.contentMode = UIViewContentModeScaleAspectFill;
    filterView.backgroundColor = [UIColor lightGrayColor];
    filterView.layer.masksToBounds = YES;

}
/**
 滤镜
 */
- (UIImage *)filterImage:(UIImage *)image {
    CIImage *inputImg = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setDefaults];
    [filter setValue:inputImg forKey:@"inputImage"];
    CIImage *outputImg = [filter valueForKey:@"outputImage"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImg = [context createCGImage:outputImg fromRect:outputImg.extent];
    UIImage *resultImg = [UIImage imageWithCGImage:cgImg];
    CGImageRelease(cgImg);
    return resultImg;
}
/**
 人脸识别
 */
- (void)identifyFaceInImageView:(UIImageView *)imageView {
    UIImage * imageInput = [imageView image];
    CIImage * image = [CIImage imageWithCGImage:imageInput.CGImage];
    
    CIContext * context = [CIContext contextWithOptions:nil];
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    
    NSArray * detectResult = [faceDetector featuresInImage:image];
    
    CGSize ciImageSize = image.extent.size;
    CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
    transform = CGAffineTransformTranslate(transform, 0, -ciImageSize.height);
    
    for (CIFaceFeature * faceFeature in detectResult) {
        
        CGRect faceViewBounds = CGRectApplyAffineTransform(faceFeature.bounds, transform);
        CGSize viewSize = imageView.bounds.size;
        CGFloat scale = MIN(viewSize.width/ciImageSize.width, viewSize.height/ciImageSize.height);
        CGFloat offsetX = (viewSize.width - ciImageSize.width * scale) / 2;
        CGFloat offsetY = (viewSize.height - ciImageSize.height * scale) / 2;
        
        faceViewBounds = CGRectApplyAffineTransform(faceViewBounds, CGAffineTransformMakeScale(scale, scale));
        faceViewBounds.origin.x += offsetX;
        faceViewBounds.origin.y += offsetY;
        
        UIView *faceView = [[UIView alloc] initWithFrame:faceViewBounds];
        faceView.layer.borderColor = [UIColor redColor].CGColor;
        faceView.layer.borderWidth = 1;
        [imageView addSubview:faceView];
        
        
        if (faceFeature.hasLeftEyePosition) {
            
        }
        
        
        if (faceFeature.hasRightEyePosition) {
            
        }
        
        if (faceFeature.hasMouthPosition) {
            
        }
    }
    
}
- (void)popImageSelection {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please select the way of pick image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self popImagePickerWithType:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"Album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self popImagePickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:cameraAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)popImagePickerWithType:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = type;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    /**
     info:
     {
     UIImagePickerControllerImageURL = "file:///private/var/mobile/Containers/Data/Application/C968D0A3-A3F5-4BBF-82BC-8734437F99B8/tmp/7680450A-92B1-446A-9931-45A869FC04E4.jpeg";
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x1c40a91e0> size {3024, 4032} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=E947E3CC-91E0-4049-88CD-BE415C2B12D4&ext=JPG";
     }
     */
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        NSInteger count = self.imageView.subviews.count;
        if (count > 0) {
            for (NSInteger i = count - 1; i >= 0; i--) {
                UIView *subview = self.imageView.subviews[i];
                [subview removeFromSuperview];
            }
        }
        self.imageView.image = image;
        self.filterView.image = [self filterImage:image];
        [self identifyFaceInImageView:self.imageView];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
