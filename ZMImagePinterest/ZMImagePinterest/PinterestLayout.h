//
//  PinterestLayout.h
//  ZMPinterest
//
//  Created by zm on 16/5/6.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^CellHeightBlock)(NSIndexPath *indexPath,CGFloat cellWidth);

@interface PinterestLayout : UICollectionViewLayout

@property (nonatomic, strong)   NSMutableDictionary *colHeightDic; //存储每列的高度

/**
 *  根据indexPath和宽度得到图片等比高度
 *
 *  @param block
 */
- (void)getCellHeightBlock:(CellHeightBlock)block;


@end
