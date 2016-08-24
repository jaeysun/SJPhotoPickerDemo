//
//  SJPhotoPickerManager.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPhotoPickerManager.h"

#import "SJAlbumModel.h"

@interface SJPhotoPickerManager()

@end


@implementation SJPhotoPickerManager

+ (instancetype)shareSJPhotoPickerManager {
    
    static SJPhotoPickerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[SJPhotoPickerManager alloc] init];
        }
    });
    return manager;
}

- (void)requestImageForPHAsset:(PHAsset *)asset targetSize:(CGSize)targetSize imageResult:(ImageBlcok)imageBlock {
    
    // 使用PHImageManager从PHAsset中请求图片
    PHImageManager *imageManager = [[PHImageManager alloc] init];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    [imageManager requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            imageBlock(result);
        }
    }];
    
}

- (void)requestAlbumsWithType:(PHAssetCollectionType)type albumResult:(AlbumBlock)albumBlock {
    // 列出所有相册智能相册
    PHFetchResult *assetCollectionResult = [PHAssetCollection fetchAssetCollectionsWithType:type subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    NSMutableArray *albumArray = [NSMutableArray array];
    // 这时 smartAlbums 中保存的应该是各个智能相册对应的 PHAssetCollection
    for (NSInteger i = 0; i < assetCollectionResult.count; i++) {
        
        // 获取一个相册（PHAssetCollection）
        PHCollection *collection = assetCollectionResult[i];
        if ([collection class] == [PHAssetCollection class]) {
            
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            
            PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            
            if (assetResult.count != 0) {
                SJAlbumModel *model = [[SJAlbumModel alloc] init];
                model.title = collection.localizedTitle;
                model.assetResult = assetResult;
                
                [albumArray addObject:model];
            }
        }
        albumBlock(albumArray);
    }

}

@end
