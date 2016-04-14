//
//  CarouselCollectionCell.m
//
//  Created by Pan on 15/7/20.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import "PSCarouselCollectionCell.h"

@implementation PSCarouselCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.adImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.adImageView];
        self.adImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

@end
