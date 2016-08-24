//  SJPickPhotoController.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/19.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPickPhotoController.h"

#import "SJPhotoPicker.h"
#import "SJPhotoPickerMacro.h"

#import "SJPhotoModel.h"

#import "SJPickPhotoCell.h"
#import "SJPhotoPickerToolBar.h"

#import "SJPreviewPhotoController.h"

@interface SJPickPhotoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SJPreviewPhotoControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SJPhotoPickerToolBar *toolBar;

/**
 *  所有照片
 */
@property (nonatomic, strong) NSMutableArray<SJPhotoModel *> *photoArray;
/**
 *  选择的照片
 */
@property (nonatomic, strong) NSMutableArray<SJPhotoModel *> *pickedArray;

@end

static NSString *ID_SJPickPhotoCell = @"sJPickPhotoCell";

@implementation SJPickPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark 数据初始化
- (void)setupDatas {
    
    // photoArray
    {
        self.photoArray = [NSMutableArray array];
        
        for (PHAsset *asset in self.assetResult) {
            
            SJPhotoModel *model = [[SJPhotoModel alloc] init];
            model.asset = asset;
            model.inAlbumIndex = self.photoArray.count;
            model.pickedIndex = 0;
            model.isPicked = NO;
            [self.photoArray addObject:model];
        }
        [self.collectionView reloadData];
    }
    
    // pickedArray
    {
        self.pickedArray = [NSMutableArray array];
    }
}

#pragma mark 视图初始化
- (void)setupViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.title.length == 0) {
        self.title = @"所有照片";
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarBtnAction:)];
    
    // collectionView
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5.0f;
        layout.minimumInteritemSpacing = 0.0f;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_W, SCREEN_H - 49) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[SJPickPhotoCell class] forCellWithReuseIdentifier:ID_SJPickPhotoCell];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.pagingEnabled = NO;
        [self.view addSubview:self.collectionView];
    }
    
    // toolBar
    {
        self.toolBar = [[SJPhotoPickerToolBar alloc] init];
        [self.toolBar.leftBtn addTarget:self action:@selector(previewPhotoAction:) forControlEvents:(UIControlEventTouchUpInside)];
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
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SJPickPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID_SJPickPhotoCell forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor yellowColor];
  
    SJPhotoModel *model = self.photoArray[indexPath.row];
    [cell setModel:model];
    
    __weak typeof(cell) weakCell = cell;
    
    cell.pickBtnBlock = ^(SJPhotoModel *curPickModel) {
        [self changeCell:weakCell WithModel:curPickModel];
    };
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(Image_W, Image_W);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    SJPreviewPhotoController *vc = [[SJPreviewPhotoController alloc] init];
    vc.delegate = self;
    vc.previewArray = [self.photoArray mutableCopy];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- 点击事件
#pragma mark-

#pragma mark 预览
- (void)previewPhotoAction:(UIButton *)sender {
    
    SJPreviewPhotoController *vc = [[SJPreviewPhotoController alloc] init];
    vc.delegate = self;
    vc.previewArray = [self.pickedArray mutableCopy];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark 取消
- (void)rightBarBtnAction:(UIBarButtonItem *)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 确定
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

#pragma mark- 其他方法
#pragma mark-

#pragma mark 通过改变改变model值，改变cell状态
- (void)pickedArrayChangeWithModel:(SJPhotoModel *)model {

    NSIndexPath *changedIndexP =[NSIndexPath indexPathForItem:model.inAlbumIndex inSection:0];
    SJPickPhotoCell *changedCell = (SJPickPhotoCell *)[self.collectionView cellForItemAtIndexPath:changedIndexP];
    [self changeCell:changedCell WithModel:model];
}



- (void)changeCell:(SJPickPhotoCell *)changedCell WithModel:(SJPhotoModel *)changedModel {
    
    
    if (changedModel.isPicked) {
        
        [changedCell modelChangePickedIndex:self.pickedArray.count + 1];
        [self.pickedArray addObject:changedModel];
        
    }
    else {
        
        [self.pickedArray removeObject:changedModel];
        
        // 更新剩下选择的图片
        for (int i = 0; i < self.pickedArray.count; i ++) {
            
            SJPhotoModel *otherPickedModel = self.pickedArray[i];
            
            if (otherPickedModel.pickedIndex > changedModel.pickedIndex) {
                
                otherPickedModel.pickedIndex -= 1;
                
                NSIndexPath *indexP =[NSIndexPath indexPathForItem:otherPickedModel.inAlbumIndex inSection:0];
                SJPickPhotoCell *otherCell = (SJPickPhotoCell *)[self.collectionView cellForItemAtIndexPath:indexP];
                
                [otherCell modelChangePickedIndex:otherPickedModel.pickedIndex];
                
            }
        }
        // 更新 取消选择的图片
        [changedCell modelChangePickedIndex:0];
    }
    
    // 更改工具栏状态信息
    [self.toolBar changePickedIndex:self.pickedArray.count];
}


@end
