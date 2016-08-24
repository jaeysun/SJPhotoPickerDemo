
//
//  SJPhotoPickerMacro.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/17.
//  Copyright © 2016年 S.J. All rights reserved.
//

#ifndef SJPhotoPickerMacro_h
#define SJPhotoPickerMacro_h


#define SCREEN_W CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_H CGRectGetHeight([UIScreen mainScreen].bounds)

#define Image_W (SCREEN_W - 15.0) / 4.0

#define MAXCOUNT 20



/**
 *  Notification
 */

#define PICKEDARRAY_SJNOTIFY_CHANGE @"SJPhotoPickedArrayChangeNotification" // 选择图片图片数组中数据改变

#import "SJPhotoPickerManager.h"




#endif /* SJPhotoPickerMacro_h */
