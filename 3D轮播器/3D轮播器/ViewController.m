//
//  ViewController.m
//  3D轮播器
//
//  Created by user on 16/10/28.
//  Copyright © 2016年 YueYaJiHua. All rights reserved.
//

#import "ViewController.h"
#import "ZJRCarouselView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZJRCarouselView *banerV = [[ZJRCarouselView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 180) imageArray:@[@"1",@"2",@"3",@"4"]];
    [self.view addSubview:banerV];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
