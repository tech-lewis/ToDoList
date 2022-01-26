//
//  CU_GoodsCategoryController.m
//  cu
//
//  Created by 钟小麦 on 2019/8/21.
//  Copyright © 2019 NZ. All rights reserved.
//

#import "CU_GoodsCategoryController.h"
#import "CU_ChangeLanguageTool.h"
#import "CU_Define.h"
#import "CU_Const.h"
#import "CU_TypeLeftView.h"
#import "CU_TypeRigthContainView.h"

@interface CU_GoodsCategoryController ()<AB_TypeLeftViewDelegate,AB_TypeRightContainCellDelegate>

@property (nonatomic,strong) CU_TypeLeftView *leftContainView;

@property (nonatomic,strong) CU_TypeRigthContainView *rightContainView;

@end

@implementation CU_GoodsCategoryController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = kLocalLanguage(@"Category_Tab") ;
  //注册切换语言通知
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage:) name:kChangeLanguageNotice object:nil];
  [self setupUI];
}

////切换语言通知处理
//- (void)changeLanguage:(NSNotification *) notification{
//    self.gk_navTitle = kLocalLanguage(@"Category_Tab") ;
//}



#pragma mark - AB_TypeLeftViewDelegate

-(void)AB_TypeLeftViewDidClickLeftItem:(id)obj{
    
    //
    //    [self setRightViewSelectIndex:obj];
//    self.rightContainView.subCateModel = obj;
    //    self.rightContainView.subCategorysList = obj.subList;
    
}



-(void)AB_TypeRigthContainViewDidClickItem:(CU_GoodsCategoryModel *)item  subCateModel:(CU_GoodsCategoryModel *)subCateModel{
    
//    AB_GoodsListViewController *goodsListVc = [[AB_GoodsListViewController alloc]init];
//    goodsListVc.leftTitleL.text = item.name;
//    goodsListVc.ID = subCateModel.ID;
//    goodsListVc.cateId = @"3";
//    [self.navigationController pushViewController:goodsListVc animated:YES];
    
}


-(void)setRightViewSelectIndex:(id )obj {
    
    //    NSInteger index = 0;
    //
    //    for (int i = 0 ; i < self.subCategorysArray.count; i++) {
    //
    //        NSArray *list  = self.subCategorysArray[i];
    //        IB_TypeListModel *firstObj = list.firstObject;
    //        if (firstObj.parentId.integerValue == obj.ID.integerValue) {
    //            index = i;
    //            break;
    //        }
    //
    //    }
    //
    //    self.rightContainView.selectIndexSection = index;
}


-(void)PRO_TypeViewControllerDidScrollRightView:(NSInteger)index {
    
    //选中左边的
    self.leftContainView.selectIndexSection = index;
}



#pragma mark - seutpUI

-(void)setupUI {
    // self.gk_navLineHidden = NO;
    _leftContainView = [[CU_TypeLeftView alloc]init];
    _leftContainView.delegate = self;
    //    _leftContainView.hidden = YES;
    
    _rightContainView = [[CU_TypeRigthContainView alloc]init];
    _rightContainView.delegate = self;
    //    _rightContainView.delegate = self;
    //    _rightContainView.hidden = YES;
    
    [self.view addSubview:_leftContainView];
    [self.view addSubview:_rightContainView];
    
    [_leftContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.navigationController.navigationBar.mas_bottom);;
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        make.width.mas_equalTo(@(kAdaptedWidth(80)));
    }];
    
    [_rightContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.bottom.equalTo(self.leftContainView);
        make.left.equalTo(self.leftContainView.mas_right);
    }];
    
    
    
    
    
}

@end
