//
//  ICELableLayout.h
//  Example
//
//  Created by WLY on 16/7/13.
//  Copyright © 2016年 WLY. All rights reserved.
//
/**
 *  标签类布局: Item 宽度不定 高度固定, 
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ICELableLayout;

/**
 *  返回布局数据
 */
@protocol ICELableLayout <NSObject>
@required
/**
 *  单元格宽度
 */
- (CGFloat)g_Labellayout:(ICELableLayout *)layout widthForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

//区头    区尾 大小
- (CGSize)g_labelLayout:(ICELableLayout *)layout sizeForSupmentView:(NSString *)ElementKind atIndexPath:(NSIndexPath *)indexPath;
/**
 *  计算出总高度后回调
 */
- (void)g_lableLayout:(ICELableLayout *)layout contentHeight:(CGFloat)contentHeight;

@end

@interface ICELableLayout : UICollectionViewLayout
@property (nonatomic, assign) id<ICELableLayout> delegate;
/**
 *  单元格之间行间距

 */
@property (nonatomic, assign) CGFloat        interItemSpacing;
/**
 *  单元格之间行间距
 */
@property (nonatomic, assign) CGFloat        lineItemSpacing;
/**
 *  组内内边距
 */
@property (nonatomic, assign) UIEdgeInsets   sectionInset;
/**
 *  单元格高度: 设置单元格统一高度
 */
@property (nonatomic, assign) CGFloat        itemHigh;



@end


NS_ASSUME_NONNULL_END
