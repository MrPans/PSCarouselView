//
//  CarouselCell.m
//
//  Created by Pan on 16/1/31.
//  Copyright © 2016年 Pan. All rights reserved.
//

#import "CarouselCell.h"
#import <PSCarouselView/PSCarouselView.h>
#import "Macros.h"

@interface CarouselCell ()

@property (weak, nonatomic) IBOutlet PSCarouselView *carouselView;


@end

@implementation CarouselCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.carouselView.placeholder = PLACEHOLDER_IMAGE;
    self.carouselView.autoMoving = YES;
    self.carouselView.movingTimeInterval = 1.5f;
}

- (void)setImageURLs:(NSArray<NSURL *> *)imageURLs
{
    _imageURLs = imageURLs;
    self.carouselView.imageURLs = imageURLs;
    [self.carouselView startMoving];
}

@end
