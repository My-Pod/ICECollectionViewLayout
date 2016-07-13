//
//  ICEWaterfallVC.m
//  Example
//
//  Created by WLY on 16/7/12.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICEWaterfallVC.h"
#import "ICECollectionViewCell.h"
#import "ICELableLayout.h"


@interface ICEWaterfallVC ()<UICollectionViewDataSource, UICollectionViewDelegate, ICELableLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray          *datasource;

@end

@implementation ICEWaterfallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[@"吃fasfsadfsdfasfsafasfasfasdfasdfsadfasdfdsa", @"喝fasfsafsdafsfasfsdafsadfsafsdfasdfsdfasdfsadsdafas", @"玩", @"乐",@"说学逗唱"];
    self.datasource = @[arr, arr, arr, arr];
    [self.collectionView reloadData];
    // Do any additional setup after loading the view.
}


- (NSArray *)datasource{
    
    if (!_datasource) {
        _datasource = [NSArray array];
        
    }
    return _datasource;
}



- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewLayout *layout = [self layout];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ICECollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"H"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"F"];
        _collectionView.allowsMultipleSelection = YES;
        [self.view addSubview:_collectionView];
        
            }
    return _collectionView;
}

- (UICollectionViewLayout *)layout{
    
    ICELableLayout *layout = [[ICELableLayout alloc] init];
    layout.interItemSpacing = 10;
    layout.lineItemSpacing = 10;
    layout.itemHigh = 20;
    layout.delegate = self;
    layout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    
    return layout;
}

#pragma mark - ICESimpleLayout
/**
 *  计算文本size
 */
static inline CGSize ICESizeWithString(NSString *string,  CGFloat max_w,CGFloat max_h, UIFont *font) {
    
    return [string boundingRectWithSize:CGSizeMake(max_w, max_h) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}


- (CGFloat)g_Labellayout:(ICELableLayout *)layout widthForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ICESizeWithString([self.datasource[indexPath.section] objectAtIndex:indexPath.row], 1000, 40, [UIFont systemFontOfSize:17]).width + 10;
}

- (CGSize)g_labelLayout:(ICELableLayout *)layout sizeForSupmentView:(NSString *)ElementKind atIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datasource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.datasource[section] count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ICECollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    [cell.lable removeFromSuperview];
    cell.lable = nil;
    cell.lable.text = [self.datasource[indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
       UICollectionReusableView *reusable = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"F" forIndexPath:indexPath];
        reusable.backgroundColor = [UIColor grayColor];
        return reusable;
    }else{
        
        UICollectionReusableView *resuableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"H" forIndexPath:indexPath];
        resuableView.backgroundColor = [UIColor yellowColor];
        return resuableView;
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSInteger number = [collectionView numberOfItemsInSection:indexPath.section];
        NSInteger section = indexPath.section;
        
        for (int i = 0 ; i < number; i ++) {
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:section]];
            if (i == indexPath.row) {
                cell.selected = YES;
            }else{
                cell.selected = NO;
            }
        }
    }
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (![NSStringFromCGRect(self.collectionView.frame) isEqualToString:NSStringFromCGRect(self.view.bounds)]) {
        self.collectionView.frame = self.view.bounds;
    }
}

@end
