//
//  SJPhotoAlbumCell.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/22.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPhotoAlbumCell.h"
#import "SJPhotoPickerMacro.h"

@interface SJPhotoAlbumCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *underLine;

@end


@implementation SJPhotoAlbumCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self s_setupCellView];
        
    }
    return self;
}

- (void)s_setupCellView {
    
    CGFloat X_Padding = 15.0;
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(X_Padding, 0, 55, 54)];
    self.imgView.backgroundColor= [UIColor blueColor];
    [self.contentView addSubview:self.imgView];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 15 , 0,SCREEN_W - CGRectGetWidth(self.imgView.frame) - 15 * 2 - 30, 54)];
    [self.contentView addSubview:self.titleLab];
    
    
    self.underLine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame) + 15 , CGRectGetMaxY(self.titleLab.frame),SCREEN_W - CGRectGetWidth(self.imgView.frame) - 15 * 2, 1)];
    self.underLine.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [self.contentView addSubview:self.underLine];
    
}

- (NSString *)title {
    return self.title;
}

- (void)setTitle:(NSString *)title {
    self.titleLab.attributedText = [self attributedString:title];
}

- (UIImage *)img {
    return  self.img;
}

- (void)setImg:(UIImage *)img {
    self.imgView.image = img;
}


/**
 *  更改字符串的前两个空格之间字符串的颜色
 *
 *  @param txt 要改变颜色的字符床
 *
 *  @return 改变后的字符串
 */
- (NSMutableAttributedString *)attributedString:(NSString *)txt {
    
    // 查找出前两个空格的位置
    NSInteger start = 0;
    NSInteger end = 0;
    NSRange countRange = NSMakeRange(0, 0);
    
    NSString *leftString = @"（";
    int leftAsciiCode = [leftString characterAtIndex:0]; // 65
    
    NSString *rightString = @"）";
    int rightAsciiCode = [rightString characterAtIndex:0]; // 65
    
    for (int i = 0 ; i < txt.length; i ++) {
        if ([txt characterAtIndex:i] == leftAsciiCode) {
            start = i;
        }
        
        if([txt characterAtIndex:i] == rightAsciiCode){
            end = i;
        }
        countRange = NSMakeRange(start, end - start + 1);
    }
    // 改变范围内字符颜色
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:txt];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:countRange];
    return attributeStr;
}

@end