//
//  CarouselView.m
//
//  Created by Pan on 15/7/20.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#define SELF_WIDTH              self.frame.size.width
#define REUSE_IDENTIFIER        [PSCarouselCollectionCell description]

#define MIN_MOVING_TIMEINTERVAL       0.1 //最小滚动时间间隔
#define DEFAULT_MOVING_TIMEINTERVAL   3.0 //默认滚动时间间隔

#import "PSCarouselView.h"
#import "PSCarouselCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface PSCarouselView()<UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,getter=isNeedRefresh) BOOL needRefresh;

@end

//IB_DESIGNABLE
@implementation PSCarouselView
@synthesize imageURLs = _imageURLs;

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
      [self setup];
  }
  return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}


- (void)layoutSubviews
{
    if (self.isNeedRefresh && self.imageURLs.count)
    {
        //最左边一张图其实是最后一张图，因此移动到第二张图，也就是imageURL的第一个URL的图。
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        self.needRefresh = NO;
    }
    // layoutSubviews 仅仅会lay out 当前屏幕的View.所以要先滚动位置，然后调用layoutSubViews;

    [super layoutSubviews];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public Method

- (void)startMoving
{
    [self addTimer];
}

- (void)stopMoving
{
    [self removeTimer];
}

#pragma mark - Private Method

- (void)setup
{
    _imageViewMode = UIViewContentModeScaleAspectFill;
    _movingTimeInterval = DEFAULT_MOVING_TIMEINTERVAL;
    _autoMoving = NO;

    self.delegate = self;
    self.dataSource = self;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    if ([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]])
    {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
    }
    [self registerClass:[PSCarouselCollectionCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER];
    [self registerNofitication];
}


- (void)addTimer
{
    [self removeTimer];
    NSTimeInterval speed = self.movingTimeInterval < MIN_MOVING_TIMEINTERVAL ? DEFAULT_MOVING_TIMEINTERVAL : self.movingTimeInterval;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:speed target:self selector:@selector(moveToNextPage) userInfo:nil repeats:YES];
    self.timer.tolerance = 0.1 * speed;// for increased power savings and responsiveness
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)moveToNextPage
{
    if (self.imageURLs.count > 1)
    {
        NSIndexPath *currentIndexPath = [self indexPathForItemAtPoint:self.contentOffset];
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item + 1
                                                         inSection:currentIndexPath.section];
        [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (void)tellDelegateCurrentPage
{
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:self.contentOffset];
    NSInteger page = indexPath.item - 1;
    if ([self.pageDelegate respondsToSelector:@selector(carousel:didMoveToPage:)])
    {
        [self.pageDelegate carousel:self didMoveToPage:page];
    }
}

- (void)registerNofitication
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return MAX([self.imageURLs count],1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PSCarouselCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];

    cell.adImageView.contentMode = self.imageViewMode;

    if (![self.imageURLs count])
    {
        [cell.adImageView setImage:self.placeholder];
        return cell;
    }
    
    [cell.adImageView sd_setImageWithURL:[self.imageURLs objectAtIndex:indexPath.item] placeholderImage:self.placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if ([self.pageDelegate respondsToSelector:@selector(carousel:didDownloadImages:atPage:)])
        {
            [self.pageDelegate carousel:self didDownloadImages:image atPage:[self pageWithIndexPath:indexPath]];
        }
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.pageDelegate respondsToSelector:@selector(carousel:didTouchPage:)])
    {
        [self.pageDelegate carousel:self didTouchPage:[self pageWithIndexPath:indexPath]];
    }
}

- (NSUInteger)pageWithIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger page = 0;
    NSUInteger lastIndex = [self.imageURLs count] - 3;
    
    if (indexPath.item == 0)
    {
        page = lastIndex;
    }
    else if (indexPath.item == self.imageURLs.count - 1)
    {
        page = 0;
    }
    else
    {
        page = indexPath.item - 1;
    }
    return page;
}

#pragma mark - UIScrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self jumpWithContentOffset:scrollView.contentOffset];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:scrollView.contentOffset];
    //轮播滚动到最后一页的那一份动画不需要告诉代理跳转到哪一页了。
    if (indexPath.item < (self.imageURLs.count - 1))
    {
        //轮播滚动的时候 移动到了哪一页
        [self tellDelegateCurrentPage];
    }
}

//用户手动拖拽，暂停一下自动轮播
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

//用户拖拽完成，恢复自动轮播（如果需要的话）并依据滑动方向来进行相对应的界面变化
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.isAutoMoving)
    {
        [self addTimer];
    }
    [self jumpWithContentOffset:scrollView.contentOffset];
    //用户手动拖拽的时候 移动到了哪一页
    [self tellDelegateCurrentPage];

}
#pragma mark - Private
- (void)jumpToLastImage
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.imageURLs count] - 2 inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)jumpToFirstImage
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)jumpWithContentOffset:(CGPoint)contentOffset
{
    //向左滑动时切换imageView
    if (contentOffset.x <= 0)
    {
        [self jumpToLastImage];
    }
    //向右滑动时切换imageView
    if (contentOffset.x >= ([self.imageURLs count] - 1) * SELF_WIDTH)
    {
        [self jumpToFirstImage];
    }
}

#pragma mark - Notification
//程序被暂停的时候，应该停止计时器
- (void)applicationWillResignActive
{
    [self stopMoving];
}

//程序从暂停状态回归的时候，重新启动计时器
- (void)applicationDidBecomeActive
{
    if (self.isAutoMoving)
    {
        [self startMoving];
    }
}

#pragma mark - Getter and Setter

- (NSArray *)imageURLs
{
    if (!_imageURLs)
    {
        _imageURLs = [NSArray array];
    }
    return _imageURLs;
}

- (void)setImageURLs:(NSArray *)imageURLs
{
    _imageURLs = imageURLs;
    if ([imageURLs count])
    {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:[imageURLs lastObject]];
        [arr addObjectsFromArray:imageURLs];
        [arr addObject:[imageURLs firstObject]];
        _imageURLs = [NSArray arrayWithArray:arr];
    }
    [self reloadData];
    _needRefresh = YES;
}

- (void)setMovingTimeInterval:(CGFloat)movingTimeInterval
{
    _movingTimeInterval = movingTimeInterval;
    if (self.timer)
    {
        [self startMoving];
    }
}
@end
