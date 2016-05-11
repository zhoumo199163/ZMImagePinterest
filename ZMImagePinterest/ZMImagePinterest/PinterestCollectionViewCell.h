//
//  PinterestCollectionViewCell.h
//  ZMPinterest
//
//  Created by zm on 16/5/6.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinterestCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)setImageViewWithimageName:(NSString *)imageName;

@end
