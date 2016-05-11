//
//  PinterestCollectionViewCell.m
//  ZMPinterest
//
//  Created by zm on 16/5/6.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PinterestCollectionViewCell.h"

@implementation PinterestCollectionViewCell

- (void)setImageViewWithimageName:(NSString *)imageName{
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}

@end
