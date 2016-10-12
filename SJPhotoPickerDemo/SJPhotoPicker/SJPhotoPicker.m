//
//  SJPhotoPicker.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/23.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPhotoPicker.h"
#import "SJPhotoPickerNavController.h"

@implementation SJPhotoPicker

+ (instancetype)shareSJPhotoPicker {
    
    static SJPhotoPicker *photoPicker = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!photoPicker) {
            photoPicker = [[SJPhotoPicker alloc] init];
        }
    });
    return photoPicker;
}

- (void) showPhotoPickerToController:(UIViewController *)controller pickedAssets:(SJPhotoPickerBlock)photoPickerBlcok {

    NSLog(@"崩溃!!! 你需要在info.plist 中添加访问PhotoLibary权限控制(Privacy - Photo Library Usage Description)");
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                    
                case PHAuthorizationStatusNotDetermined:
                {
                    NSLog(@"用户还没有做出选择");
                    break;
                }
                case PHAuthorizationStatusAuthorized:
                {
                  
                    NSLog(@"用户允许当前应用访问相册");
                    SJPhotoPickerNavController *vc = [[SJPhotoPickerNavController alloc] init];
                    [controller presentViewController:vc animated:YES completion:nil];
                    self.photoPickerBlock = photoPickerBlcok;
                    
                    break;
                }
                case PHAuthorizationStatusDenied:
                {
                    NSLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
                    break;
                }
                case PHAuthorizationStatusRestricted:
                {
                    NSLog(@"家长控制,不允许访问");
                    break;
                }
                default:
                {
                    NSLog(@"default");
                    break;
                }
            }
        });
    }];
}


@end
