//
//  CarouselView.h
//
//  Created by Pan on 15/7/20.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSCarouselView;

typedef NS_ENUM(NSInteger, PSCarouselViewScrollDirection) {
    PSCarouselViewScrollDirectionRightToLeft = 0,
    PSCarouselViewScrollDirectionLeftToRight
};

/**
 *  PSCarouselView的代理方法
 */
@protocol PSCarouselDelegate <NSObject>
@optional

/// @warning  SDWebImage库是必备的。使用本控件请确保导入了SDWebImage
/// @warning  SDWebImage is required. Make sure that you had import SDWebImage when use this widget;

/**
 *  告诉代理滚动到哪一页了
 *
 *  @param carousel 触发此代理方法的PSCarouselView
 *  @param page     目前滚动到那一页了，相当于`imageURL`的index。
 */
- (void)carousel:(nonnull PSCarouselView *)carousel didMoveToPage:(NSUInteger)page;

/**
 *  告诉代理用户点击了某一页
 *
 *  @param carousel 触发此代理方法的PSCarouselView
 *  @param page     用户点击的页码，相当于`imageURL`的index。
 */
- (void)carousel:(nonnull PSCarouselView *)carousel didTouchPage:(NSUInteger)page;

/**
 *  告诉代理，下载好了哪一张图片
 *
 *  @param carousel 触发此代理方法的PSCarouselView
 *  @param image    下载好的图片
 *  @param page     标明该图片是哪一页的图片，相当于`imageURL`的index。
 */
- (void)carousel:(nonnull PSCarouselView *)carousel didDownloadImages:(nonnull UIImage *)image atPage:(NSUInteger)page;
@end

/**
 *  一个简单易用的广告轮播控件
 *  @see 设计思路请查看[这里]:http://shengpan.net/pscarouselview/
 */
@interface PSCarouselView : UICollectionView

/**
 *  需要被轮播的图片URL数组。只需要给这个这个属性赋值，就会自动获取图片。刷新数据请再次给此属性赋值。
 */
@property (nullable, nonatomic, strong) NSArray *imageURLs;

/**
 *  没有轮播图时的占位图
 */
@property (nullable, nonatomic, strong) IBInspectable UIImage *placeholder;

/**
 *   是否自动轮播,默认为NO
 */
@property (nonatomic,getter=isAutoMoving) IBInspectable BOOL autoMoving;

/**
 *  滚动速率 默认为3.0 即3秒翻页一次
 */
@property (nonatomic) IBInspectable CGFloat movingTimeInterval;

/**
 *  图片显示的缩放模式,默认为ScaleAspectFill
 */
@property (nonatomic) UIViewContentMode imageViewMode;

/**
 *  PSCarouselView的代理
 */
@property (nullable, nonatomic, weak) id<PSCarouselDelegate> pageDelegate;

/**
 *  自动滚动时的滚动方向。默认是 PSCarouselViewScrollDirectionRightToLeft。
 */
@property (nonatomic, assign) PSCarouselViewScrollDirection scrollDirection;

/**
 *  初始化并返回一个指定Frame的PSCarouselView
 *
 *  @param frame 在SuperView中的Frame
 *
 *  @return PSCarouselView的实例
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 *  从Storyboard/Xib中读取时会走这个方法，直接调用无效。
 *
 *  @param aDecoder 一个解压对象
 *
 *  @return PSCarouselView的实例
 */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 *  开始轮播。
 *  当图片数量 < 2 张 或者 isAutoMoving == NO 的时候，调用此 API 不会产生任何效果。
 */
- (void)startMoving;

/**
 *  停止轮播
 */
- (void)stopMoving;
@end
