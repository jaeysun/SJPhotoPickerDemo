//
//  SJAlbumModel.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/22.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface SJAlbumModel : NSObject

@property (nonatomic, strong) PHFetchResult *assetResult;
@property (nonatomic, strong) NSString *title;

@end
