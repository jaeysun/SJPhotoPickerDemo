//
//  SJPreviewPhotoCell.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void(^SingleTapEventBlock)(void);

@interface SJPreviewPhotoCell : UICollectionViewCell

@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) CGFloat zoomScale;

@property (nonatomic, strong) SingleTapEventBlock singleTapEvent;

@end
