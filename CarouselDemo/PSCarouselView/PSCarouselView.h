//
//  CarouselView.h
//
//  Created by Pan on 15/7/20.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSCarouselView;
@protocol PSCarouselDelegate <NSObject>
@optional

#warning  SDWebImage库是必备的。使用本控件请确保导入了SDWebImage  
#warning  SDWebImage is required. Make sure that you had import SDWebImage when use this widget;

/**
 *  告诉代理滚动到哪一页了
 *
 *  @param carousel self
 *  @param page     已经计算好，直接使用即可
 */
- (void)carousel:(PSCarouselView *)carousel didMoveToPage:(NSUInteger)page;

/**
 *  告诉代理用户点击了某一页
 *
 *  @param carousel
 *  @param page imageURL的index
 */
- (void)carousel:(PSCarouselView *)carousel didTouchPage:(NSUInteger)page;
@end


@interface PSCarouselView : UICollectionView
@property (nonatomic, strong) NSArray *imageURLs;/**< 必须赋值。只要给这个imageURL赋值，会自动获取图片。刷新请再次给此属性赋值*/

@property (nonatomic, strong) UIImage *placeholder;/**< 没有轮播图时的占位图*/

@property (nonatomic,getter=isAutoMoving) BOOL autoMoving;/**< 是否自动轮播,默认为NO*/

@property (nonatomic) NSTimeInterval movingTimeInterval;/**< 滚动数率 默认为3.0 即3秒翻页一次*/

@property (nonatomic, weak) id<PSCarouselDelegate> pageDelegate;

- (void)startMoving;

- (void)stopMoving;
@end
