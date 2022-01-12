//
//  VM_HomeViewController.m
//  VehicleMaster_iOS
//
//  Created by zc on 2018/12/4.
//  Copyright © 2018 qipeimao.com. All rights reserved.
//

#import "IB_HomeViewController.h"
#import "IB_HomeSearchView.h"

#import "NetworkTool+Home.h"
#import "IB_HomeGoodsCell.h"
#import "IB_HomeKindCell.h"
#import "IB_HomeBannerCell.h"
#import "IB_HomeSectionTitleHeaderView.h"

#import "IB_StatisModel.h"

@interface IB_HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) IB_HomeSearchView *searchView;

@property (nonatomic,strong) NSArray *configerGroups;

@end

static NSString *const ReuseID_HomeGoodsCell = @"IB_HomeGoodsCell";
static NSString *const ReuseID_HomeKindCell = @"IB_HomeKindCell";
static NSString *const ReuseID_HomeBannerCell = @"IB_HomeBannerCell";
static NSString *const ReuseID_HomeSectionTitleHeaderView = @"IB_HomeSectionTitleHeaderView";

@implementation IB_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self configeGroupData];
    
    [self requestHomeData];
    
}

#pragma mark - Request

-(void)requestHomeData {
    
    IB_HomeParam *param = [[IB_HomeParam alloc]init];
    
    [NetworkTool requestHomeData:param completion:^(BOOL sucess, id obj, NSString *message) {
        
    }];
}

#pragma mark - configerGroupData

-(void)configeGroupData {
 
    IB_StatisModel *configerModel = [[IB_StatisModel alloc]init];
    configerModel.reuseID = ReuseID_HomeBannerCell;
    configerModel.itemSize = CGSizeMake(kScreenWidth, kScreenWidth * 0.65);
    configerModel.insets = UIEdgeInsetsZero;
    configerModel.itemCount = 1;

    
    IB_StatisModel *configerModel1= [[IB_StatisModel alloc]init];
    configerModel1.reuseID = ReuseID_HomeKindCell;
    configerModel1.itemSize = CGSizeMake(kScreenWidth, kScreenWidth * 0.56);
    configerModel1.insets = UIEdgeInsetsMake(10, 0, 0, 0);
    configerModel1.itemCount = 1;
    
    IB_StatisModel *configerModel2 = [[IB_StatisModel alloc]init];
    configerModel2.headerViewReuseId = ReuseID_HomeSectionTitleHeaderView;
    configerModel2.reuseID = ReuseID_HomeGoodsCell;
    CGFloat itemW = (kScreenWidth - 10*3)/2.0;
    configerModel2.itemSize = CGSizeMake(itemW, itemW+40);
    configerModel2.minInterSpace = 10;
    configerModel2.minLineSpace = 10;
    configerModel2.itemCount = 20;
    configerModel2.insets = UIEdgeInsetsMake(0, 10, 0, 10);
    configerModel2.headerHeight = 44;
    
    self.configerGroups = @[configerModel,configerModel1,configerModel2];
    
}

#pragma mark - UICollectionView_DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.configerGroups.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    IB_StatisModel *configerModel = self.configerGroups[section];
    return configerModel.itemCount;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IB_StatisModel *configerModel = self.configerGroups[indexPath.section];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:configerModel.reuseID forIndexPath:indexPath];

    
    return cell;
}



#pragma mark cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    IB_StatisModel *configerModel = self.configerGroups[indexPath.section];
    return configerModel.itemSize;
}

//定义每个Section 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    IB_StatisModel *configerModel = self.configerGroups[section];
    return configerModel.insets;
    
}

//这个是两行之间的间距（上下cell间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    IB_StatisModel *configerModel = self.configerGroups[section];
    return configerModel.minLineSpace;
}

//这个方法是两个之间的间距（同一行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    IB_StatisModel *configerModel = self.configerGroups[section];
    return configerModel.minInterSpace;
}

#pragma mark 头headerView的大小
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    IB_StatisModel *configerModel = self.configerGroups[section];
    return CGSizeMake(kScreenWidth, configerModel.headerHeight);
}

//footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

//#pragma mark 头headerView的布局
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader){
        
        IB_StatisModel *configerModel = self.configerGroups[indexPath.section];
        IB_HomeSectionTitleHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:configerModel.headerViewReuseId forIndexPath:indexPath];
        return headerView;
        
    }else if (kind == UICollectionElementKindSectionFooter){
        // 尾部
        return  nil;
    }
    return nil;
}

#pragma mark - setupUI

-(void)setupUI {
    
    
    _searchView = [[IB_HomeSearchView alloc]init];
    [self.navigationBarView addSubview:_searchView];
    
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBarView.statusBar.mas_bottom).offset(4.5);
        make.centerX.equalTo(self.navigationBarView);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 35));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView  alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    [_collectionView registerClass:[IB_HomeBannerCell class] forCellWithReuseIdentifier:ReuseID_HomeBannerCell];
    [_collectionView registerNib:[UINib nibWithNibName:@"IB_HomeKindCell" bundle:nil] forCellWithReuseIdentifier:ReuseID_HomeKindCell];
    [_collectionView registerNib:[UINib nibWithNibName:@"IB_HomeGoodsCell" bundle:nil] forCellWithReuseIdentifier:ReuseID_HomeGoodsCell];
    [_collectionView registerClass:[IB_HomeSectionTitleHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ReuseID_HomeSectionTitleHeaderView];
    
    
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationBarView.mas_bottom);
    }];
    
    
    self.navigationBarView.leftButtonItem  = [KSNavigationButtonItem itemWithImage:[UIImage imageNamed:@"scan"] handle:^(KSNavigationButtonItem *item) {
        
    }];
    
    self.navigationBarView.rightButtonItem  = [KSNavigationButtonItem itemWithImage:[UIImage imageNamed:@"scan"] handle:^(KSNavigationButtonItem *item) {
        
    }];
}


@end
