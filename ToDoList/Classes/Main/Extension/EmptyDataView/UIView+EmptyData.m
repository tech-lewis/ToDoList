//
//  UIView+EmptyData.m
//  TestEmptyDataView
//
//  Created by zc on 2017/11/11.
//  Copyright © 2017年 com.eenet. All rights reserved.
//

#import "UIView+EmptyData.h"
#import <objc/runtime.h>

@implementation UIView (EmptyData)


-(EmptyDataView *)emptyView
{
    EmptyDataView *emptyDataV;
    
    for (id subView in self.subviews) {//获取已添加进的EmptyView,没有则创建
        
        if ([subView isKindOfClass:[EmptyDataView class]]) {
            emptyDataV = subView;
            break;
        }
    }
    
    if (emptyDataV == nil) {
        emptyDataV = [EmptyDataView new];
        
//        [self swizzleMethod];
        
        [self addSubview:emptyDataV];
    }

//    [self swizzleMethod];
//    NSLog(@"%@---",self);
    emptyDataV.frame = [UIScreen mainScreen].bounds;
  
    [self insertSubview:emptyDataV atIndex:0];
    
    return emptyDataV;
}


- (void)setEmptyView:(EmptyDataView *)emptyView
{
   
}

#pragma mark - 私有方法

-(void)swizzleMethod
{
    
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        
        //交换tableView的reloadData方法
        Method method1 =  class_getInstanceMethod([tableView class], @selector(reloadData));
        Method mehtod2 = class_getInstanceMethod([self class], @selector(es_reloadData));
        method_exchangeImplementations(method1, mehtod2);
      
        //交互tableView的endUpdates方法
        Method method3 =  class_getInstanceMethod([tableView class], @selector(endUpdates));
        Method mehtod4 = class_getInstanceMethod([self class], @selector(es_updateData));
        method_exchangeImplementations(method3, mehtod4);
        
    }
    
    if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
     
        //交换collectionView的reloadData方法
        Method method1 =  class_getInstanceMethod([collectionView class], @selector(reloadData));
        Method mehtod2 = class_getInstanceMethod([self class], @selector(es_reloadData));
        method_exchangeImplementations(method1, mehtod2);
        

        
    }
    
   
}


//更新view的状态
-(void)es_reloadData
{
    
    [self es_reloadData];
    
    NSInteger count =   [self itemCounts];
    
    if (count) {
        [self.emptyView hideEmptyDataView:YES];
    }else{
        [self.emptyView showEmptyDataView:YES];
    }

}


-(void)es_updateData
{
    [self es_reloadData];
    
    NSInteger count =   [self itemCounts];
    
    if (count) {
        [self.emptyView hideEmptyDataView:YES];
    }else{
        [self.emptyView showEmptyDataView:YES];
    }
}


-(NSInteger)itemCounts
{
    
    NSInteger count = 0;
    
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        
        id <UITableViewDataSource>dataSource = tableView.dataSource;
        
        NSInteger sections =   [dataSource numberOfSectionsInTableView:tableView];
    
        
        for ( NSInteger i = 0; i < sections; i++) {
            count += [dataSource tableView:tableView numberOfRowsInSection:sections];
            if (count) break;
        }
        
    }
    
    if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource>dataSource = collectionView.dataSource;
        
        NSInteger sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        for (NSInteger i = 0; i < sections; i++) {
            
            count += [collectionView numberOfItemsInSection:sections];
            
            if (count) break;
        }
        
    }
    
    
    return count;
}


@end
