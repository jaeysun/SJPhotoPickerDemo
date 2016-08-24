//
//  SJPreviewPhotoController.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPreviewPhotoController.h"

#import <Photos/Photos.h>

#import "SJPhotoPickerNavBar.h"
#import "SJPhotoPickerToolBar.h"
#import "SJPreviewPhotoCell.h"

#import "SJPhotoPicker.h"

@interface SJPreviewPhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource,SJPhotoPickerNavBarDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SJPhotoPickerToolBar *toolBar;
@property (nonatomic, strong) SJPhotoPickerNavBar *navBar;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSMutableArray *pickedArray;
@property (nonatomic, strong) SJPhotoModel *operatingModel;

@end

static NSString *ID_SJPreviewPhotoCell = @"sJPreviewPhotoCell";


@implementation SJPreviewPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupViews];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 数据初始化
- (void)setupDatas {
  
    self.pickedArray = [NSMutableArray array];
    
    for (SJPhotoModel *model in self.previewArray) {
        if (model.isPicked) {
            [self.pickedArray addObject:model];
        }
    }
    [self.collectionView reloadData];
}

#pragma mark 视图初始化
- (void)setupViews {
    
    // collectionView
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.0f;
        layout.minimumInteritemSpacing = 0.0f;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_W, SCREEN_H + 64) collectionViewLayout:layout];
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[SJPreviewPhotoCell class] forCellWithReuseIdentifier:ID_SJPreviewPhotoCell];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.previewArray.count - 1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
        self.operatingModel = [self.previewArray lastObject];
        [self.view addSubview:self.collectionView];
    }

    // nav
    {
       
        self.navBar = [[SJPhotoPickerNavBar alloc] init];
        self.navBar.delegate = self;
        SJPhotoModel *lastModel = [self.previewArray lastObject];
        
        if (self.title.length == 0) {
            self.navBar.leftBtnTitle = @"";
        }
        self.navBar.barTitle = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.previewArray.count,(unsigned long)self.previewArray.count];
        
        if (lastModel.isPicked) {
          
            [self.navBar setRightBtnTitleIndex:lastModel.pickedIndex];
        }
        [self.view addSubview:self.navBar];
 
    }
    
    // toolBar
    {
        self.toolBar = [[SJPhotoPickerToolBar alloc] init];
        self.toolBar.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.3];
        self.toolBar.rightBtn.backgroundColor = [UIColor colorWithRed:46/255.0 green:178/255.0 blue:242/255.0 alpha:1];
        [self.toolBar.rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        
         self.toolBar.leftBtn.hidden = YES;
        [self.toolBar.rightBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:self.toolBar];
    }
}

#pragma mark- UICollectionViewDelegate DataSource
#pragma mark-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.previewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SJPreviewPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID_SJPreviewPhotoCell forIndexPath:indexPath];
    cell.zoomScale = 1.0;
    SJPhotoModel *model = self.previewArray[indexPath.item];
    cell.asset = model.asset;
    cell.singleTapEvent = ^(){
        [self.toolBar changeHideState];
        [self.navBar changeHideState];
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_W, SCREEN_H);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = (NSInteger)scrollView.contentOffset.x / SCREEN_W;
    
    self.operatingModel = self.previewArray[index];
    
    self.navBar.barTitle = [NSString stringWithFormat:@"%lu/%lu",index  + 1,(unsigned long)self.previewArray.count];
    [self.navBar setRightBtnTitleIndex:self.operatingModel.pickedIndex];
    
}

#pragma mark- 点击事件
#pragma mark-

#pragma mark 单选框点击（SJ...NavBarDelegate）
- (void)rightBtnAction:(UIButton *)sender {

    self.operatingModel.isPicked = !self.operatingModel.isPicked;
    
    // 代理传值
    [self.delegate pickedArrayChangeWithModel:self.operatingModel];
    
    if (self.operatingModel.isPicked) {
        
        NSInteger pickedIndex = self.pickedArray.count + 1;
        self.operatingModel.pickedIndex = pickedIndex;
        [self.pickedArray addObject:self.operatingModel];
          [self.navBar setRightBtnTitleIndex:pickedIndex];
    }
    else {
        [self.pickedArray removeObject:self.operatingModel];
       
        self.operatingModel.pickedIndex = 0;
        for (int i = 0; i < self.pickedArray.count; i ++) {
            SJPhotoModel *model = self.pickedArray[i];
            model.pickedIndex  = i + 1;
        }
     [self.navBar setRightBtnTitleIndex:0];
    }
}

#pragma mark 确定按钮
- (void)sureBtnAction:(UIButton *)sender {
    NSMutableArray *assetArray = [NSMutableArray array];
    for (SJPhotoModel *model in self.pickedArray) {
        PHAsset *asset = model.asset;
        [assetArray addObject:asset];
    }
    
    SJPhotoPicker *photoPicker = [SJPhotoPicker shareSJPhotoPicker];
    photoPicker.photoPickerBlock(assetArray);

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
