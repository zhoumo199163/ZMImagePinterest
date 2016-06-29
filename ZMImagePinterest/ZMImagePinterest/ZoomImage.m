//
//  ZoomImage.m
//  ZMImagePinterest
//
//  Created by zm on 16/5/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ZoomImage.h"

#define screenHeight [[UIScreen mainScreen]bounds].size.height //屏幕高度
#define screenWidth [[UIScreen mainScreen]bounds].size.width   //屏幕宽度

static CGRect currentImageViewRect;
static CGFloat zoomScale;
static CGFloat animationTime = 0.5f;

@implementation ZoomImage

+ (void)FullScreenShowImageView:(UIImageView *)needShowImageView{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    //将需要展示的imageView在subView中的Rect转换成window上的Rect
    currentImageViewRect = [needShowImageView convertRect:needShowImageView.bounds toView:window];
    
    // 临时imageView
    UIImageView *tmpImageView = [[UIImageView alloc] initWithFrame:currentImageViewRect];
    tmpImageView.image = needShowImageView.image;
    tmpImageView.userInteractionEnabled = YES;

    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenWidth, screenHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.alpha = 0;
    
    [backgroundView addSubview:tmpImageView];
    [window addSubview:backgroundView];
    
    //点击缩小手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOutImageView:)];
    [tmpImageView addGestureRecognizer:tap];
    
    CGSize imageViewSize = needShowImageView.frame.size;
    
    CGFloat widthScale = screenWidth/imageViewSize.width;
    CGFloat heightScale = screenHeight/imageViewSize.height;
    
    zoomScale = widthScale<=heightScale?widthScale:heightScale;
    
    CGFloat zoomX = (screenWidth - imageViewSize.width*zoomScale)/2;
    CGFloat zoomY = (screenHeight - imageViewSize.height*zoomScale)/2;
    
    [UIView animateWithDuration:animationTime animations:^{
        tmpImageView.frame = CGRectMake(zoomX, zoomY, imageViewSize.width*zoomScale, imageViewSize.height*zoomScale);
        backgroundView.alpha = 1;
    }];
    
}

+ (void)zoomOutImageView:(UIGestureRecognizer *)tap{
    UIView *tmpImageView = tap.view;
    UIView *backgroundView = [tmpImageView superview];
    [UIView animateWithDuration:animationTime animations:^{
        tmpImageView.frame = currentImageViewRect;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];

    }];
}

@end
