//
//  ZJRCarouselView.m
//  3D轮播器
//
//  Created by user on 16/10/28.
//  Copyright © 2016年 YueYaJiHua. All rights reserved.
//

#import "ZJRCarouselView.h"

@interface ZJRCarouselView ()<CAAnimationDelegate>

@property(nonatomic, weak)UIImageView *imageV;

@property(nonatomic, strong)NSArray *imageArr;

@property(nonatomic, weak)UIPageControl *pageControl;

@property(nonatomic, assign)NSInteger count;

@property(nonatomic, assign)NSInteger currentPage;

@property(nonatomic, strong)NSTimer *timer;

@end

@implementation ZJRCarouselView

- (UIImageView *)imageV
{
    if (!_imageV) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        imageView.backgroundColor = [UIColor lightGrayColor];
        
        imageView.userInteractionEnabled = YES;
        
        _imageV = imageView;
        
        [self addSubview:_imageV];
    }
    return _imageV;
}

- (NSTimer *)timer
{
    if (!_timer) {
        
        _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(swipFromRight) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.imageArr.count;
        CGSize size = [pageControl sizeForNumberOfPages:self.imageArr.count];
        pageControl.frame = CGRectMake(0, 0, size.width, size.height);
        pageControl.center = CGPointMake(self.center.x, self.frame.size.height - 10);
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl = pageControl;
        
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        
        self.currentPage = 0;
        self.imageArr = imageArray;
        self.imageV.image = [UIImage imageNamed:self.imageArr[self.currentPage]];
        
        UISwipeGestureRecognizer *rightRe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipFromRight)];
        [rightRe setDirection:UISwipeGestureRecognizerDirectionLeft];
        
        UISwipeGestureRecognizer *leftRe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipFromLeft)];
        [leftRe setDirection:UISwipeGestureRecognizerDirectionRight];
        
        [self.imageV addGestureRecognizer:rightRe];
        [self.imageV addGestureRecognizer:leftRe];
        
        [self timer];
        [self pageControl];
    }
    
    return self;
}

- (void)swipFromRight
{
    self.currentPage++;
    if (self.currentPage >= self.imageArr.count) self.currentPage = 0;
    self.pageControl.currentPage = self.currentPage;
    
    self.imageV.image = [UIImage imageNamed:self.imageArr[self.currentPage]];
    
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.5;
    transition.delegate = self;
    [self.imageV.layer addAnimation:transition forKey:nil];
}


- (void)swipFromLeft
{
    self.currentPage--;
    if (self.currentPage < 0) self.currentPage = self.imageArr.count - 1;
    self.pageControl.currentPage = self.currentPage;
    
    self.imageV.image = [UIImage imageNamed:self.imageArr[self.currentPage]];
    
    CATransition *transition2 = [[CATransition alloc] init];
    transition2.type = @"cube";
    transition2.subtype = kCATransitionFromLeft;
    transition2.duration = 1.5;
    transition2.delegate = self;
    [self.imageV.layer addAnimation:transition2 forKey:nil];
}



#pragma mark -CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.timer) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
    self.imageV.userInteractionEnabled = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.timer) {
        
        [self.timer invalidate];
        self.timer = nil;
        
        [self timer];
    }
    
    self.imageV.userInteractionEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
