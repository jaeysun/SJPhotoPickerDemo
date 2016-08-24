//
//  SJPhotoAlbumsController.m
//  SJPhotoPickerDemo
//
//  Created by Jaesun on 16/8/22.
//  Copyright © 2016年 S.J. All rights reserved.
//

#import "SJPhotoAlbumsController.h"
#import "SJPhotoPickerMacro.h"

#import "SJPhotoAlbumCell.h"

#import "SJPickPhotoController.h"
#import "SJPhotoPickerManager.h"
#import "SJAlbumModel.h"

@interface SJPhotoAlbumsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

/**
 *  相册数组
 */
@property (nonatomic, strong) NSMutableArray *albumArray;

@end

static NSString *ID_SJPhotoAlbumCell = @"sJPhotoAlbumCell";


@implementation SJPhotoAlbumsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatas];
    [self setupViews];
    
    
    SJPickPhotoController *vc = [[SJPickPhotoController alloc] init];
    SJAlbumModel *model = [[SJAlbumModel alloc] init];
    model = self.albumArray[0];
    
    vc.assetResult = model.assetResult;
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark 数据初始化
- (void)setupDatas {
    
    [[SJPhotoPickerManager shareSJPhotoPickerManager] requestAlbumsWithType:PHAssetCollectionTypeSmartAlbum albumResult:^(NSArray *albumArray) {
        self.albumArray = [albumArray mutableCopy];
    }];
    [self.tableView reloadData];
}

#pragma mark 视图初始化
- (void)setupViews {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarBtnAction:)];
    
    // tableView
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W,SCREEN_H) style:(UITableViewStyleGrouped)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[SJPhotoAlbumCell class] forCellReuseIdentifier:ID_SJPhotoAlbumCell];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.tableView];
    }
    
}

#pragma mark- UITableViewDelegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SJPhotoAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_SJPhotoAlbumCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[SJPhotoAlbumCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID_SJPhotoAlbumCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SJAlbumModel *model = self.albumArray[indexPath.row];
    
    cell.title = [NSString stringWithFormat:@"%@（%lu）",model.title,model.assetResult.count];
    [[SJPhotoPickerManager shareSJPhotoPickerManager] requestImageForPHAsset:model.assetResult[0] targetSize:CGSizeMake(55, 55) imageResult:^(UIImage *image) {
        cell.img = image;
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SJPickPhotoController *vc = [[SJPickPhotoController alloc] init];
    SJAlbumModel *model = self.albumArray[indexPath.row];
    vc.assetResult = model.assetResult;
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBarBtnAction:(UIBarButtonItem *)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
