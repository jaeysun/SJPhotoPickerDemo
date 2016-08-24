//
//  SJPhotoPickerNavBar.h
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/22.
//  Copyright © 2016年 S.J. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol SJPhotoPickerNavBarDelegate <NSObject>

@optional
- (void)leftBtnAction:(UIButton *)sender;
- (void)rightBtnAction:(UIButton *)sender;

@end

@interface SJPhotoPickerNavBar : UIView

@property (nonatomic, strong) id delegate;

@property (nonatomic, assign) NSInteger rightBtnTitleIndex;
@property (nonatomic, strong) NSString *barTitle;
@property (nonatomic, strong) NSString *leftBtnTitle;

- (void)changeHideState;

@end
