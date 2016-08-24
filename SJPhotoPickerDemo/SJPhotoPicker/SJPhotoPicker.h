//
//  SJPhotoPicker.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/23.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SJPhotoPickerManager.h"

typedef void(^SJPhotoPickerBlock)(NSArray <PHAsset *> *assets);

@interface SJPhotoPicker : NSObject

@property (nonatomic, strong) SJPhotoPickerBlock photoPickerBlock;

+ (instancetype)shareSJPhotoPicker;

- (void) showPhotoPickerToController:(UIViewController *)controller pickedAssets:(SJPhotoPickerBlock)photoPickerBlcok;

@end
