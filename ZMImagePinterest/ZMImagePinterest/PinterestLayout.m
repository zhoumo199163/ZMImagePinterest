//
//  PinterestLayout.m
//  ZMPinterest
//
//  Created by zm on 16/5/6.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PinterestLayout.h"

#define screenHeight [[UIScreen mainScreen]bounds].size.height //屏幕高度
#define screenWidth [[UIScreen mainScreen]bounds].size.width   //屏幕宽度

static const NSInteger columnNumber = 3;//列数
static const CGFloat topSpacing = 15; //上间距
static const CGFloat leftSpacing = 15;//左间距
static const CGFloat rightSpacing = 15;//右间距
static const CGFloat rowSpacing = 10.0f; //行间距
static const CGFloat columnSpacing = 10.0f;//列间距

@interface PinterestLayout(){
    CGFloat cellWidth;         //图片宽度平均且统一
    NSMutableArray *layoutAttributesArray; //每个item的layoutAttrubutes
    CellHeightBlock heightBlock;
}

@end

@implementation PinterestLayout

- (instancetype)init{
    self = [super init];
    if(self){
        
        //cell宽度 = （屏宽 - 左边距 - 右边距- 图片间距*（列数-1））/列数
        cellWidth = (screenWidth - leftSpacing - rightSpacing - rowSpacing*(columnNumber - 1))/columnNumber;
        self.colHeightDic = [NSMutableDictionary new];
        layoutAttributesArray = [NSMutableArray new];
    }
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
    
    for(NSInteger i = 0;i<columnNumber;i++){
        [self.colHeightDic setObject:@(topSpacing) forKey:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for(NSInteger i = 0;i<count;i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [layoutAttributesArray addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame;
    //item高
    CGFloat height = heightBlock(indexPath,cellWidth);
    
    //找出最短列
    __block NSString *minHeightCol = @"0";
    //循环字典
    [self.colHeightDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if([self.colHeightDic[minHeightCol] floatValue] > [obj floatValue]){
            minHeightCol = key;
        }
    }];
    
    CGFloat positionY = [self.colHeightDic[minHeightCol] floatValue];
    //高度 = 初始位置 + item高度 + 列间距
    self.colHeightDic[minHeightCol] = @(positionY + height + columnSpacing);
    //第几列
    NSInteger col = [minHeightCol integerValue];
    
    CGFloat positionX = leftSpacing + (cellWidth + rowSpacing)*col;
    
    frame.origin = CGPointMake(positionX, positionY);
    frame.size = CGSizeMake(cellWidth, height);
    layoutAttributes.frame = frame;
    
    return layoutAttributes;
}

//返回视图框内item的属性，可以直接返回所有item属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return layoutAttributesArray;
}

//可滚动范围
- (CGSize)collectionViewContentSize{
    CGSize size;
    __block NSString *maxHeightCol = @"0";
    //遍历最长列
    [self.colHeightDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if([self.colHeightDic[maxHeightCol] floatValue] < [obj floatValue]){
            maxHeightCol = key;
        }
    }];
    size = CGSizeMake(screenWidth, [self.colHeightDic[maxHeightCol] floatValue]);
    
    return size;
}

- (void)getCellHeightBlock:(CellHeightBlock)block{
    if(heightBlock != block){
        heightBlock = block;
    }
}

@end
