//
//  ViewController.m
//  CarouselDemo
//
//  Created by Pan on 15/8/13.
//  Copyright (c) 2015年 Pan. All rights reserved.
//



#import "ViewController.h"
#import "PSCarouselView.h"
#import "Macros.h"

@interface ViewController ()<PSCarouselDelegate>

@property (weak, nonatomic) IBOutlet PSCarouselView *carouselView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

- (IBAction)didDragSpeedSlider:(UISlider *)sender;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCarouselView];
    [self setupPageControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.carouselView startMoving];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.carouselView stopMoving];
}

#pragma mark - Private Method

- (void)setupCarouselView
{
    self.carouselView.imageURLs = [self imageURLs];
    self.carouselView.placeholder = PLACEHOLDER_IMAGE;
    self.carouselView.pageDelegate = self;
    self.carouselView.autoMoving = YES;
    self.carouselView.movingTimeInterval = 1.5f;
}

- (void)setupPageControl
{
    self.pageControl.numberOfPages = [[self imageURLs] count];
}

- (NSArray *)imageURLs
{
    return @[[NSURL URLWithString:IMAGE_URLSTRING0],
             [NSURL URLWithString:IMAGE_URLSTRING1],
             [NSURL URLWithString:IMAGE_URLSTRING2]];
}

#pragma mark - PSCarouselDelegate

- (void)carousel:(PSCarouselView *)carousel didMoveToPage:(NSUInteger)page
{
    self.pageControl.currentPage = page;
}

- (void)carousel:(PSCarouselView *)carousel didTouchPage:(NSUInteger)page
{
    NSLog(@"PSCarouselView did TOUCH No.%ld page",page);
}

- (void)carousel:(PSCarouselView *)carousel
didDownloadImages:(UIImage *)image
          atPage:(NSUInteger)page
{
    NSLog(@"PSCarouselView did DOWNLOAD No.%ld page",page);
}

- (IBAction)didDragSpeedSlider:(UISlider *)sender
{
    self.speedLabel.text = [NSString stringWithFormat:@"滚动速度:%.1lf秒/次",sender.value];
    self.carouselView.movingTimeInterval = sender.value;
    [self.carouselView stopMoving];
    [self.carouselView startMoving];
}
@end
