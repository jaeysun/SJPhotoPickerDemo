//
//  SJPhotoPickerManager.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef void(^ImageBlcok)(UIImage *image);

typedef void(^AlbumBlock)(NSArray *albumArray);

@interface SJPhotoPickerManager : NSObject

+ (instancetype)shareSJPhotoPickerManager;

- (void)requestImageForPHAsset:(PHAsset *)asset targetSize:(CGSize)targetSize imageResult:(ImageBlcok)imageBlock;
- (void)requestAlbumsWithType:(PHAssetCollectionType)type albumResult:(AlbumBlock)albumBlock;

@end
