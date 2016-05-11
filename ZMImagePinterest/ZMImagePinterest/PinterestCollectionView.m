//
//  PinterestCollectionView.m
//  ZMPinterest
//
//  Created by zm on 16/5/6.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PinterestCollectionView.h"
#import "PinterestLayout.h"
#import "PinterestCollectionViewCell.h"

static const NSInteger initLoadImageNum = 24; //第一次加载图片的数量
static const NSInteger addRefreshImageNum = 12; //向下滑动加载图片数量
static const NSInteger refreshImageHeight = 100; // 距离底部告诉小于100时加载图片
static const NSInteger stopRefreshImageNum = 100; // 图片加载超过100 停止继续加载

@interface PinterestCollectionView()<UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate>{
    CGFloat beginScrollOffsetY; //存储刚开始滑动的位置
}

@property (nonatomic, strong) PinterestLayout *pinterestLayout;
@property (nonatomic, strong) NSMutableArray *imagesArray; //imageUrls

@end

@implementation PinterestCollectionView

static NSString * const reuseIdentifier = @"PinterestCell";

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame collectionViewLayout:self.pinterestLayout];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self initImagesArray];
        self.dataSource = self;
        self.delegate = self;
        UINib *cellNib = [UINib nibWithNibName:@"PinterestCollectionViewCell" bundle:nil];
        [self registerNib:cellNib forCellWithReuseIdentifier:reuseIdentifier];
    }
    return self;
}

- (PinterestLayout *)pinterestLayout{
    if(_pinterestLayout == nil){
        _pinterestLayout = [[PinterestLayout alloc] init];
        __weak typeof(self) weakSelf = self;
        [_pinterestLayout getCellHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat cellWidth) {
            
            UIImage *image = [UIImage imageNamed:weakSelf.imagesArray[indexPath.row]];
            CGFloat height = [weakSelf getHeightForImageSize:image.size width:cellWidth];
            return height;
        }];
    }
    return _pinterestLayout;
}

- (void)initImagesArray{
    self.imagesArray = [NSMutableArray new];
    for(int num = 0; num<initLoadImageNum;num++){
        //添加图片
        int random = arc4random()%6;//[0,4)
        [self.imagesArray addObject:[NSString stringWithFormat:@"IMG_%d.jpg",random+1]];
    }
}

//根据宽度等比求高度
- (CGFloat )getHeightForImageSize:(CGSize)imageSize width:(CGFloat)width{
    CGFloat height = imageSize.height * width /imageSize.width;
    return height;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PinterestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    [cell setImageViewWithimageName:self.imagesArray[indexPath.row]];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"开始滑动");
    beginScrollOffsetY = scrollView.contentOffset.y;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 1.判断滑动方向
    CGFloat didScrollOffsetY = scrollView.contentOffset.y;
    if(didScrollOffsetY > beginScrollOffsetY){
        NSLog(@"像下滑动");
        
        // 2.距离底部还差《=100 时加载图片
        NSInteger minHeight = [self getColMinHeight];
        NSInteger selfHeight = self.frame.size.height;  //屏高
        NSInteger imageCount = [self.imagesArray count];
        
        
        if( (minHeight - (scrollView.contentOffset.y + selfHeight) <= refreshImageHeight ) && imageCount <= stopRefreshImageNum){
            NSLog(@"加载图片");
            [self addRefreshImage];
            [self reloadData];
            
        }
    }
    else{
        NSLog(@"像上滑动");
    }
}

//找出最短列
- (CGFloat)getColMinHeight{
    
    __block NSString *minHeightCol = @"0";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.pinterestLayout.colHeightDic];
    //循环字典
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if([dic[minHeightCol] floatValue] > [obj floatValue]){
            minHeightCol = key;
        }
    }];
    
    return [dic[minHeightCol] integerValue];
    
}

// 增加图片数组
- (void)addRefreshImage{
    for(int i = 0;i<addRefreshImageNum;i++){
        int random = arc4random()%6;//[0,4)
        [self.imagesArray addObject:[NSString stringWithFormat:@"IMG_%d.jpg",random+1]];
    }
    
}


@end
