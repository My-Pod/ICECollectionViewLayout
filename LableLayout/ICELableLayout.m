//
//  ICELableLayout.m
//  Example
//
//  Created by WLY on 16/7/13.
//  Copyright © 2016年 WLY. All rights reserved.
//

#import "ICELableLayout.h"


@interface ICELableLayout (){
    //协议有效性
    struct DeleateVisable{
        BOOL sizeForSuppmentView;
    }   _deleagetVisable;
    
    CGFloat contet_W;
}

/**
 *  内容区域总宽度
 */
@property (nonatomic, assign) CGFloat                  content_w;
/**
 *  内容区域总高度
 */
@property (nonatomic, assign) CGFloat                  content_h;
/**
 *  cell 布局属性   @[@[itemsAttrs]]
 */
@property (nonatomic, strong) NSMutableArray           *itemsAtts;

/**
 *  所有区头布局属性
 */
@property (nonatomic, strong) NSMutableArray      *headerViewAtts;
/**
 *  所有区尾布局属性
 */
@property (nonatomic, strong) NSMutableArray      *footerViewAtts;
/**
 *  每一个分区的frams
 */
@property (nonatomic, strong) NSMutableArray           *sectionFrames;


@end

@implementation ICELableLayout

/**
 *  初始化变量
 */
- (void)p_initConfig{
    _itemsAtts = [NSMutableArray array];
    _sectionFrames = [NSMutableArray array];
    
    if (!_interItemSpacing) _interItemSpacing = 10;
    if (!_lineItemSpacing)  _lineItemSpacing  = 10;
    if (!_itemHigh) _itemHigh = 40;
   
    _content_h = 0;
    _content_w = self.collectionView.bounds.size.width;
    
    //协议有效性
    _deleagetVisable.sizeForSuppmentView = NO;
    if ([self.delegate respondsToSelector:@selector(g_labelLayout:sizeForSupmentView:atIndexPath:)]) {
        _deleagetVisable.sizeForSuppmentView = YES;
    }
}


- (NSMutableArray *)headerViewAtts{
    if (!_headerViewAtts) {
        _headerViewAtts = [NSMutableArray array];
    }
    return _headerViewAtts;
}

- (NSMutableArray *)footerViewAtts{
    if (!_footerViewAtts) {
        _footerViewAtts = [NSMutableArray array];
    }
    return _footerViewAtts;
}


/**
 *  获取整体的布局数据
 */
- (void)p_figureAllElementLayoutAttributes{

    NSInteger numberOfSection = self.collectionView.numberOfSections;
    CGFloat y = 0;
    
    for (int i = 0 ; i < numberOfSection; i ++) {
        
       CGFloat section_h = [self p_figureOneSectionElementLayoutAttrbutesWithY:y forSection:i];
        CGRect sectionFrame = CGRectMake(0, y, _content_w, section_h);
        [_sectionFrames addObject:[NSValue valueWithCGRect:sectionFrame]];
        y += section_h;
    }
    
    _content_h = y;
}


/**
 *  计算一个分区的布局数据,并返回这个分区的总高度
 */
- (CGFloat)p_figureOneSectionElementLayoutAttrbutesWithY:(CGFloat)y
                                           forSection:(NSInteger)section{
    CGFloat section_h = y;
    y += _sectionInset.top;
    
    //区头
    if (_deleagetVisable.sizeForSuppmentView) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        
        CGSize size = [self.delegate g_labelLayout:self sizeForSupmentView:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        CGRect frame = CGRectMake(_sectionInset.left, y, size.width, size.height);
        UICollectionViewLayoutAttributes *attrubutes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        attrubutes.frame = frame;
        
        [self.headerViewAtts addObject:attrubutes];
        y += size.height;
    }
    
    //单元格布局
    CGFloat x = _sectionInset.left;
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
    NSMutableArray *sectionItemAttrs = [NSMutableArray array];
    CGFloat line_right = _content_w - _sectionInset.right;
    
    for (int i = 0 ; i < numberOfItems; i ++) {
        //计算一个单元格的 布局
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        CGFloat item_w = [self.delegate g_Labellayout:self widthForRowAtIndexPath:indexPath];
    
        //计算frame
        CGRect frame = CGRectMake(x, y, item_w, _itemHigh);
        
        //更新 x y
        x = x + item_w + _lineItemSpacing;
        if (x >= line_right) {
            y = y + _itemHigh + _interItemSpacing;
            x = _sectionInset.left;
            frame.origin.x = x;
            frame.origin.y = y;
            x = _sectionInset.left + item_w + _lineItemSpacing;
        }
        
        //创建属性模型对象
        UICollectionViewLayoutAttributes *attrubutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        //设置frame
        attrubutes.frame = frame;
        
        //保存在属性数组中
        
        [sectionItemAttrs addObject:attrubutes];
        
    }
    
    [_itemsAtts addObject:sectionItemAttrs];
    
    
    //区尾
    
    if (_deleagetVisable.sizeForSuppmentView) {
        y = y + _itemHigh;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        CGSize size = [self.delegate g_labelLayout:self sizeForSupmentView:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        
        CGRect frame = CGRectMake(_sectionInset.left, y, size.width, size.height);
        UICollectionViewLayoutAttributes *attrubutes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
        attrubutes.frame = frame;
        
        [self.footerViewAtts addObject:attrubutes];
        y += size.height;
    }

    y += _sectionInset.bottom;
    section_h = y - section_h;
    
    return section_h;
}


- (void)prepareLayout{
    [super prepareLayout];
    [self p_initConfig];
    [self p_figureAllElementLayoutAttributes];
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(_content_w, _content_h);
}



- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *allAtts = [NSMutableArray array];
    
    NSInteger numberOfSection = self.collectionView.numberOfSections;
    
    for (int i = 0 ; i < numberOfSection; i ++) {
        CGRect sectionFrame = [_sectionFrames[i] CGRectValue];
        if (CGRectIntersectsRect(sectionFrame, rect)) {
            NSLog(@"%d", i);
            //区头
                UICollectionViewLayoutAttributes *headerAtts = self.headerViewAtts[i];
                if (CGRectIntersectsRect(headerAtts.frame, rect)) {
                    [allAtts addObject:headerAtts];
                }
            
            for (UICollectionViewLayoutAttributes *atts in self.itemsAtts[i]) {
                if (CGRectIntersectsRect(atts.frame, rect)) {
                    [allAtts addObject:atts];
                }
            }
            //区尾
                UICollectionViewLayoutAttributes *footAtts = self.footerViewAtts[i];
                if (CGRectIntersectsRect(footAtts.frame, rect)) {
                    [allAtts addObject:footAtts];
            }
        }
    }
    return allAtts;
}



- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        return _headerViewAtts[indexPath.section];
    }else{
        return _footerViewAtts[indexPath.section];
    }
}




@end
