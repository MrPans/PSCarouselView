//
//  DemoCollectionViewCell.m
//
//  Created by Pan on 16/2/2.
//  Copyright © 2016年 Pan. All rights reserved.
//

#import "DemoCollectionViewCell.h"
#import "PSCarouselView.h"
#import "Macros.h"

@interface DemoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet PSCarouselView *carouselView;

@end

@implementation DemoCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.carouselView.placeholder = PLACEHOLDER_IMAGE;
    self.carouselView.autoMoving = YES;
    self.carouselView.movingTimeInterval = 1.5f;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.carouselView.movingTimeInterval = self.speed;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageURLs = nil;
}

- (void)setImageURLs:(NSArray<NSURL *> *)imageURLs
{
    _imageURLs = imageURLs;
    self.carouselView.imageURLs = imageURLs;
    [self.carouselView startMoving];
}

- (void)setSpeed:(NSTimeInterval)speed
{
    _speed = speed;
    self.carouselView.movingTimeInterval = speed;
}
@end
