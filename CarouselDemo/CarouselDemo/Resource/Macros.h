//
//  Macros.h
//  CarouselDemo
//
//  Created by Pan on 16/1/31.
//  Copyright © 2016年 Pan. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

static NSString *const IMAGE_URLSTRING0 = @"http://img.hb.aicdn.com/0f14ad30f6c0b4e4cf96afcad7a0f9d6332e5b061b5f3c-uSUEUC_fw658";
static NSString *const IMAGE_URLSTRING1 = @"http://img.hb.aicdn.com/3f9d1434ba618579d50ae8c8476087f1a04d7ee3169f8e-zD2u09_fw658";
static NSString *const IMAGE_URLSTRING2 = @"http://img.hb.aicdn.com/81427fb53bed38bf1b6a0c5da1c5d5a485e00bd1149232-gn4CO1_fw658";

#define PLACEHOLDER_IMAGE [UIImage imageNamed:@"placeholder"]

#define IMAGE_URLS @[[NSURL URLWithString:IMAGE_URLSTRING0],[NSURL URLWithString:IMAGE_URLSTRING1],[NSURL URLWithString:IMAGE_URLSTRING2]]
#endif /* Macros_h */
