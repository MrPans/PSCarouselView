//
//  CarouselView.m
//
//  Created by Pan on 15/7/20.
//  Copyright (c) 2015年 Pan. All rights reserved.
//

#define SELF_WIDTH              self.frame.size.width
#define REUSE_IDENTIFIER        [PSCarouselCollectionCell description]

#define MIN_MOVING_TIMEINTERVAL       0.3 //最小滚动时间间隔
#define DEFAULT_MOVING_TIMEINTERVAL   3.0 //默认滚动时间间隔

#import <PSCarouselView/PSCarouselView.h>
#import "PSCarouselCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "PSWeaker.h"

@interface PSCarouselView()<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,getter=isNeedRefresh) BOOL needRefresh;
@property (nonatomic, assign) NSInteger currentPage;

@end

//IB_DESIGNABLE
@implementation PSCarouselView
@synthesize imageURLs = _imageURLs;

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    @throw [NSException exceptionWithName:@"Cannot initialize with layout"
                                   reason:@"PSCarouselView would initialize with UICollectionViewFlowLayout internally. Call initWithFrame: or init instead."
                                 userInfo:nil];
    return [self initWithFrame:CGRectZero];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
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
        // 根据滚动方向，移动到第一张或者最后一张图片的位置
        NSInteger item = self.scrollDirection == PSCarouselViewScrollDirectionRightToLeft
        ? 1
        : self.imageURLs.count - 2;
        
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
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
    [self startMovingIfNeeded];
}

- (void)stopMoving
{
    [self removeTimer];
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
            // 当且仅当从网络下载的时候提示代理 -- 下载好图片了。
            if (cacheType == SDImageCacheTypeNone)
            {
                [self.pageDelegate carousel:self didDownloadImages:image atPage:[self pageWithIndexPath:indexPath]];
            }
        }
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.pageDelegate respondsToSelector:@selector(carousel:didTouchPage:)])
    {
        [self.pageDelegate carousel:self didTouchPage:[self pageWithIndexPath:indexPath]];
    }
}


#pragma mark - UIScrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self adjustCurrentPageWithContentOffset:scrollView.contentOffset];
    [self jumpWithContentOffset:scrollView.contentOffset];
}

// 用户手动拖拽，暂停一下自动轮播
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

// 用户拖拽完成，恢复自动轮播（如果需要的话）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self startMovingIfNeeded];
}

#pragma mark - UITraitEnvironment

// fix #10
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    self.needRefresh = YES;
    [self reloadData];
}

#pragma mark - Private Method

- (void)jumpToLastImage
{
    NSInteger lastItem = self.imageURLs.count - 2;
    if (lastItem < 0) {
        return;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lastItem inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)jumpToFirstImage
{
    if (self.imageURLs.count < 2) {
        return;
    }
    
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

- (void)adjustCurrentPageWithContentOffset:(CGPoint)contentOffset
{
    // 以中线作为判断点，过了中线才算是到了下一页。
    CGPoint adjustPoint = CGPointMake(contentOffset.x + (0.5 * SELF_WIDTH),
                                      contentOffset.y);
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:adjustPoint];
    NSInteger currentPage = [self pageWithIndexPath:indexPath];
    
    // 只有当页面的值改变的时候才赋值并通知 Delegate, 防止值不变的时候不停地通知
    if (self.currentPage == currentPage)
    {
        return;
    }
    
    self.currentPage = currentPage;
    [self tellDelegateCurrentPage];
}

// 将当前的 indexPath 的 item 值 转成 page
- (NSInteger)pageWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger page;
    NSInteger index = indexPath.item;
    NSInteger suffixIndex = self.imageURLs.count - 1;
    NSInteger prefixIndex = 0;
    
    NSInteger firstPage = 0;
    NSInteger lastPage = suffixIndex - 2;
    
    if (index == prefixIndex)
    {
        page = lastPage;
    }
    else if (index == suffixIndex)
    {
        page = firstPage;
    }
    else
    {
        page = index - 1;
    }
    return page;
}

- (void)setup
{
    _imageViewMode = UIViewContentModeScaleAspectFill;
    _movingTimeInterval = DEFAULT_MOVING_TIMEINTERVAL;
    _autoMoving = NO;
    _scrollDirection = PSCarouselViewScrollDirectionRightToLeft;
    
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
    NSBundle *frameworkBundle = [NSBundle bundleForClass:self.class];
    NSURL *bundleURL = [frameworkBundle URLForResource:PSCarouselView.description
                                withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    UINib *nib = [UINib nibWithNibName:REUSE_IDENTIFIER bundle:resourceBundle];
    [self registerNib:nib forCellWithReuseIdentifier:REUSE_IDENTIFIER];
    [self registerNofitication];
}

- (void)registerNofitication
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)addTimer
{
    [self removeTimer];
    NSTimeInterval speed = self.movingTimeInterval < MIN_MOVING_TIMEINTERVAL ? DEFAULT_MOVING_TIMEINTERVAL : self.movingTimeInterval;
    PSWeaker *weaker = [[PSWeaker alloc] initWithObject:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:speed target:weaker selector:@selector(moveToNextPage) userInfo:nil repeats:YES];
    self.timer.tolerance = 0.1 * speed;// for increased power savings and responsiveness
    
    if (self.isMovingOnTraking) {
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
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
        NSInteger item = self.scrollDirection == PSCarouselViewScrollDirectionRightToLeft
        ? (currentIndexPath.item + 1)
        : (currentIndexPath.item - 1);
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:item
                                                         inSection:currentIndexPath.section];
        [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (void)tellDelegateCurrentPage
{
    if ([self.pageDelegate respondsToSelector:@selector(carousel:didMoveToPage:)])
    {
        [self.pageDelegate carousel:self didMoveToPage:self.currentPage];
    }
}

- (void)startMovingIfNeeded
{
    if (self.isAutoMoving && self.imageURLs.count > 3)
    {
        [self addTimer];
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
    [self startMovingIfNeeded];
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
    
    // 图片数量少于 2 张的时候，手指不能滚动。
    self.scrollEnabled = imageURLs.count > 1;
}

- (void)setMovingTimeInterval:(CGFloat)movingTimeInterval
{
    _movingTimeInterval = movingTimeInterval;
    [self startMovingIfNeeded];
}
@end
