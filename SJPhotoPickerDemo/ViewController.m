//
//  ViewController.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/17.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "ViewController.h"

#import "SJPhotoPicker.h"

#import "CollectionViewCell.h"

#import "SJPhotoPickerNavController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIView *pickImageV;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [gesture addTarget:self action:@selector(pickImageAction:)];
    self.pickImageV.userInteractionEnabled = YES;
    [self.pickImageV addGestureRecognizer:gesture];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    if (self.dataArray.count == 0) {
        cell.imgView.backgroundColor = [UIColor redColor];
    }
    [[SJPhotoPickerManager shareSJPhotoPickerManager] requestImageForPHAsset:self.dataArray[indexPath.row] targetSize:PHImageManagerMaximumSize imageResult:^(UIImage *image) {
        cell.imgView.image = image;
    
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(90, 90);
}
- (void)pickImageAction:(UITapGestureRecognizer *)sender {
   
    [[SJPhotoPicker shareSJPhotoPicker] showPhotoPickerToController:self pickedAssets:^(NSArray<PHAsset *> *assets) {
        self.dataArray = [NSMutableArray arrayWithArray:assets];
        [self.collectionView reloadData];
    }];

}

@end
