//
//  ViewController.m
//  ZMImagePinterest
//
//  Created by zm on 16/5/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ViewController.h"
#import "PinterestCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PinterestCollectionView *pinterest = [[PinterestCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:pinterest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
