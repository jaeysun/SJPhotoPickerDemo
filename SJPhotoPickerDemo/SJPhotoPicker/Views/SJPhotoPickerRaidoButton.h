//
//  SJPhotoPickerRaidoButton.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/22.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RadioButtonTouchedBlock)();

@interface SJPhotoPickerRaidoButton : UIButton

@property (nonatomic, assign) NSInteger pickedIndex;

@property (nonatomic, strong) RadioButtonTouchedBlock  touchedBlock;

@end
