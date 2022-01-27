//
//  PRO_TypeRightView.m
//  QPM_Procurement_iOS
//
//  Created by zc on 2019/3/8.
//  Copyright © 2019 qpm.com. All rights reserved.
//


#import "CU_TypeRigthContainView.h"
#import "CU_TypeRightCell.h"
#import "CU_TypeRightSectionHeaderView.h"
#import "CU_GoodsCategoryModel.h"
#import "UIView+Extension.h"
#import "CU_Const.h"
#import "CU_Define.h"
@interface CU_TypeRigthContainView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,assign) BOOL didDrag;

@end

NSString *const PRO_TypeRightCellReuseID = @"CU_TypeRightCell";
NSString *const PRO_TypeRightSectionHeaderViewReuseID = @"CU_TypeRightSectionHeaderView";

@implementation CU_TypeRigthContainView

-(instancetype)initWithFrame:(CGRect)frame{
        
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

-(void)setCchlist:(NSArray *)cchlist {
    _cchlist = cchlist;
    [self.collectionView reloadData];
}
-(void)setSelectIndexSection:(NSInteger)selectIndexSection {
    
//    _selectIndexSection = selectIndexSection;
//
//    self.didDrag = NO;
    
//    if (_selectIndexSection > self.subCategorysList.count) {
//        _selectIndexSection = self.subCategorysList.count - 1;
//    }
//
//    UICollectionViewLayoutAttributes *attributes = [_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndexSection]];
//    CGRect rect = attributes.frame;
//    [_collectionView setContentOffset:CGPointMake(_collectionView.frame.origin.x, rect.origin.y - 44) animated:YES];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    if (self.didDrag == NO) return;
//
//    NSArray <NSIndexPath *> *arrays = self.collectionView.indexPathsForVisibleItems;
//
//    NSArray * sortResult = [arrays sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath  * obj1, NSIndexPath  * obj2) {
//        if (obj1.section > obj2.section) {
//            return NSOrderedDescending;
//        } else if (obj1.section < obj2.section) {
//            return NSOrderedAscending;
//        }
//        return NSOrderedSame;
//    }];
//
//
//    NSIndexPath *firstPath = sortResult.firstObject;
//
//    NSArray *currentsList = self.subCategorysList[firstPath.section];
//
//    if ([self.delegate respondsToSelector:@selector(PRO_TypeViewControllerDidScrollRightView:)]) {
//        PRO_CategorysListModel * model = currentsList.firstObject;
//        [self.delegate PRO_TypeViewControllerDidScrollRightView:model.superIndex];
//    }
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.didDrag = YES;
}


#pragma mark - UICollectionView_DataSource


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    CU_GoodsCategoryModel  *childeModel = self.subCateModel.chlist[section];
    return 5;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CU_TypeRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PRO_TypeRightCellReuseID forIndexPath:indexPath];
//    CU_GoodsCategoryModel  *childeModel = self.subCateModel.chlist[indexPath.section];
//    CU_GoodsCategoryModel  *childSubModel = self.cchlist[indexPath.row];
//
//    cell.titleL.text = childSubModel.name;
//    [cell.iconImagView base_setImageViewWithUrl:[NSString stringWithFormat:@"%@%@",kBaseUrl,childSubModel.image]];
//
    
    cell.titleL.text = @"哈哈";
//    cell.iconImagView.backgroundColor = [UIColor orangeColor];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(AB_TypeRightContainCellClickItem:section:)]) {
        [self.delegate AB_TypeRightContainCellClickItem:self.cchlist[indexPath.item]section:self.section];
    }
    
}

//#pragma mark 头headerView的布局
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader){
        
        CU_TypeRightSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PRO_TypeRightSectionHeaderViewReuseID forIndexPath:indexPath];
//        CU_GoodsCategoryModel  *childeModel = self.subCateModel.chlist[indexPath.section];
//        headerView.titleL.text = childeModel.name;
        headerView.titleL.text = @"subTitle";
        return headerView;
        
    }else if (kind == UICollectionElementKindSectionFooter){
        // 尾部
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        
        footerView.backgroundColor = kRGBA_COLOR(0, 0, 0, 0.1);
        
        return  footerView;
    }
    return nil;
}



#pragma mark cell的大小




#pragma mark 头headerView的大小
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeMake(self.width, 44);
//    return CGSizeZero;
}

//footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.width, 0.8);;
}


#pragma mark - seutpUI

-(void)setupUI {
    

    self.backgroundColor = kBACKGROUND_COLOR;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat containW = kSCREEN_WIDTH - kAdaptedWidth(80) - 15*2 - 10*2;
    CGFloat width = (containW)/3.0;
    layout.itemSize = CGSizeMake(width, width+10);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 5, 15);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView setCycle:6];
    
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_collectionView registerClass:[CU_TypeRightCell class] forCellWithReuseIdentifier:PRO_TypeRightCellReuseID];
    
    [_collectionView registerClass:[CU_TypeRightSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PRO_TypeRightSectionHeaderViewReuseID];
      [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
    
    
    [self addSubview:_collectionView ];
    
    
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-0);
    }];
}

@end
