//
//  SJPhotoModel.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPhotoModel.h"

@implementation SJPhotoModel

-(id)copyWithZone:(NSZone *)zone {
    
    SJPhotoModel *modelCopy = [[[self class] allocWithZone:zone] init];
    
    modelCopy.asset = self.asset;
    modelCopy.pickedIndex = self.pickedIndex;
    modelCopy.inAlbumIndex = self.inAlbumIndex;
    
    return modelCopy;
    
}

@end
