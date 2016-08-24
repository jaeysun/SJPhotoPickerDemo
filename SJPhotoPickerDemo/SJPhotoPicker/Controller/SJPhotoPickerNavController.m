//
//  SJPhotoPickerNavController.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/22.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPhotoPickerNavController.h"
#import "SJPhotoAlbumsController.h"

@interface SJPhotoPickerNavController ()

@end

@implementation SJPhotoPickerNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:46/255.0 green:178/255.0 blue:242/255.0 alpha:1]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    SJPhotoAlbumsController *vc = [[SJPhotoAlbumsController alloc] init];
    vc.title = @"相册";
    [self pushViewController:vc animated:NO];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
