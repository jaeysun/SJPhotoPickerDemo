//
//  SJPhotoPickerToolBar.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/22.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJPhotoPickerMacro.h"

@interface SJPhotoPickerToolBar : UIView

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;


- (void)changePickedIndex:(NSInteger) pickedIndex;
- (void)changeHideState;


@end
