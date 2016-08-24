//
//  SJPickPhotoCell.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPickPhotoCell.h"

#import "SJPhotoPickerManager.h"

@interface SJPickPhotoCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *pickBtn;

@end

@implementation SJPickPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    // imgView
    {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,Image_W, Image_W)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        self.imgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.imgView];
    }
    
    // pickBtn
    {
        self.pickBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.pickBtn.frame = CGRectMake(CGRectGetMaxX(self.imgView.frame) - CGRectGetWidth(self.imgView.frame) * 0.35,CGRectGetWidth(self.imgView.frame) * 0.05, CGRectGetWidth(self.imgView.frame) * 0.3, CGRectGetWidth(self.imgView.frame) * 0.3);
        
        self.pickBtn.layer.cornerRadius = CGRectGetWidth(self.pickBtn.frame) * 0.5;
        self.pickBtn.layer.masksToBounds = YES;
        self.pickBtn.layer.borderWidth = 1;
        self.pickBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        
        self.pickBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        self.pickBtn.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:0.6];

        [self.pickBtn addTarget:self action:@selector(pickBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.contentView addSubview:self.pickBtn];
    }
}

- (void)setModel:(SJPhotoModel *)model {
    
    _model = model;
    
    [[SJPhotoPickerManager shareSJPhotoPickerManager] requestImageForPHAsset:model.asset targetSize:CGSizeMake(Image_W, Image_W) imageResult:^(UIImage *image) {
        if (image) {
            self.imgView.image = image;
        }
    }];
  
    if (model.pickedIndex != 0) {
       
        [self.pickBtn setTitle:[NSString stringWithFormat:@"%ld",(long)model.pickedIndex] forState:(UIControlStateNormal)];
        self.pickBtn.backgroundColor = [UIColor colorWithRed:46/255.0 green:178/255.0 blue:242/255.0 alpha:1];
    }
    else {
     
        [self.pickBtn setTitle:@"" forState:(UIControlStateNormal)];
        self.pickBtn.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:0.6];
    }
}


- (void)modelChangePickedIndex:(NSInteger)pickedIndex{
    
    if (pickedIndex != 0) {
        self.model.pickedIndex = pickedIndex;
        self.model.isPicked = YES;
        [self.pickBtn setTitle:[NSString stringWithFormat:@"%ld",(long)pickedIndex] forState:(UIControlStateNormal)];
        self.pickBtn.backgroundColor = [UIColor colorWithRed:46/255.0 green:178/255.0 blue:242/255.0 alpha:1];
        [self showOscillatoryAnimationWithLayer:self.pickBtn.layer];
    }
    else {
        self.model.pickedIndex = 0;
        self.model.isPicked = NO;
        [self.pickBtn setTitle:@"" forState:(UIControlStateNormal)];
         self.pickBtn.backgroundColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:0.6];
    }
}

- (void)showOscillatoryAnimationWithLayer:(CALayer *)layer {
    
    NSNumber *animationScale1 = @(1.15);
    NSNumber *animationScale2 = @(0.85);
    NSNumber *animationScale3 = @(1.0);
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
                [layer setValue:animationScale3 forKeyPath:@"transform.scale"];
            } completion:nil];
        }];
    }];
}

- (void)pickBtnAction:(UIButton *)sender {

    self.model.isPicked = !self.model.isPicked;
    self.pickBtnBlock(self.model);
}

@end
