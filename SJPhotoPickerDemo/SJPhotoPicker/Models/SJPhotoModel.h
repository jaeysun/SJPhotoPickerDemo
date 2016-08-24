//
//  SJPhotoModel.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface SJPhotoModel : NSObject <NSCopying>

/**
 *  图片资源
 */
@property (nonatomic, strong) PHAsset *asset;

/**
 *  选中的次序起始值为1 ， 0表示没被选中
 */
@property (nonatomic, assign) NSInteger pickedIndex;

/**
 *  在相册中次序起始值为 0
 */
@property (nonatomic, assign) NSInteger inAlbumIndex;

/**
 *  是否选中 YES——选择  NO——取消选择
 */
@property (nonatomic, assign) BOOL isPicked;



@end
