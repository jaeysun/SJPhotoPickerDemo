//
//  SJPhotoPickerToolBar.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/22.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPhotoPickerToolBar.h"

@interface SJPhotoPickerToolBar()

@property (nonatomic, assign) BOOL barHide;

@end;

@implementation SJPhotoPickerToolBar

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        self.frame = CGRectMake(0, SCREEN_H - 44, SCREEN_W, 44);
        [self s_setupViews];
    }
    
    return  self;
}

- (void)s_setupViews {
    
    self.layer.shadowOffset = CGSizeMake(0, -0.3);
    self.layer.shadowColor= [UIColor lightGrayColor].CGColor;
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 1;
    
    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:0.9];
    
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.leftBtn.frame = CGRectMake(5, 7, 60, 30);
    [self.leftBtn setTitleColor:[UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1] forState:(UIControlStateNormal)];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.leftBtn setTitle:@"预览" forState:(UIControlStateNormal)];
    [self addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.rightBtn.frame = CGRectMake(SCREEN_W - 75, 7, 65, 30);
    self.rightBtn.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [self.rightBtn setTitleColor:[UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1] forState:(UIControlStateNormal)];
    self.rightBtn.layer.cornerRadius = 2;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.rightBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [self addSubview:self.rightBtn];
    
    self.barHide = NO;
    
}

- (void)changePickedIndex:(NSInteger) pickedIndex {
    if (pickedIndex == 0) {
        
        [self.leftBtn setTitleColor:[UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1] forState:(UIControlStateNormal)];
        
        self.rightBtn.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [self.rightBtn setTitleColor:[UIColor colorWithRed:195/255.0 green:195/255.0 blue:195/255.0 alpha:1] forState:(UIControlStateNormal)];
        [self.rightBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    }
    else {
        
        self.rightBtn.backgroundColor = [UIColor colorWithRed:46/255.0 green:178/255.0 blue:242/255.0 alpha:1];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.rightBtn setTitle:[NSString stringWithFormat:@"确定(%lu)",(unsigned long)pickedIndex] forState:(UIControlStateNormal)];
        [self.leftBtn setTitleColor:[UIColor colorWithRed:46/255.0 green:178/255.0 blue:242/255.0 alpha:1] forState:(UIControlStateNormal)];
    }
    
}

- (void)changeHideState {
    
    self.barHide = !self.barHide;
    
    if (self.barHide) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, 0);
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, SCREEN_H - 44, SCREEN_W, 44);
        }];
    }
    
}

@end
