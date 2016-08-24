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

    SJPhotoPickerNavController *vc = [[SJPhotoPickerNavController alloc] init];
    [controller presentViewController:vc animated:YES completion:nil];
    self.photoPickerBlock = photoPickerBlcok;
}


@end
