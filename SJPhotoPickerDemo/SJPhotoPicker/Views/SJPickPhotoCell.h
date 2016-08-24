//
//  SJPickPhotoCell.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

#import "SJPhotoPickerMacro.h"

#import "SJPhotoModel.h"

typedef void(^PickBtnBlock)(SJPhotoModel *curPickModel);
typedef void(^ModelChangeBlock)(SJPhotoModel *modifiedModel);

@interface SJPickPhotoCell : UICollectionViewCell

@property (nonatomic, strong) SJPhotoModel *model;

@property (nonatomic, strong) PickBtnBlock pickBtnBlock;

- (void)modelChangePickedIndex:(NSInteger)pickedIndex;

@end
