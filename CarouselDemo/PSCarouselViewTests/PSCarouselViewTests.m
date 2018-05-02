//
//  PSCarouselViewTests.m
//  PSCarouselViewTests
//
//  Created by Pan on 16/6/3.
//  Copyright © 2016年 Pan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <PSCarouselView/PSCarouselView.h>
#import "Macros.h"

@interface PSCarouselViewTests : XCTestCase <PSCarouselDelegate>

@property (nonatomic, strong) PSCarouselView *carouselView;
@property (nonatomic, strong) XCTestExpectation *testingExpectation;

@property (nonatomic, strong) NSMutableArray *passByIndexArray;


@end

@implementation PSCarouselViewTests

- (void)setUp
{
    [super setUp];
    [self setupCarouselView];
    self.passByIndexArray = [NSMutableArray array];
}

- (void)tearDown
{
    [super tearDown];
    self.passByIndexArray = nil;
    self.testingExpectation = nil;
}

- (void)testThatCarouselViewPageMoveSequence
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Page Move Step Pass"];
    self.testingExpectation = expectation;
    [self.carouselView startMoving];
    [self waitForExpectationsWithTimeout:10 handler:nil];
}


- (void)setupCarouselView
{
    self.carouselView = [[PSCarouselView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.carouselView.imageURLs = [self imageURLs];
    self.carouselView.placeholder = PLACEHOLDER_IMAGE;
    self.carouselView.pageDelegate = self;
    self.carouselView.autoMoving = YES;
    self.carouselView.movingTimeInterval = 0.5f;
}

- (NSArray *)imageURLs
{
    return @[[NSURL URLWithString:IMAGE_URLSTRING0],
             [NSURL URLWithString:IMAGE_URLSTRING1],
             [NSURL URLWithString:IMAGE_URLSTRING2]];
}


#pragma mark - PSCarouselDelegate
- (void)carousel:(nonnull PSCarouselView *)carousel didMoveToPage:(NSUInteger)page
{
    [self.passByIndexArray addObject:@(page)];
    // 让轮播走两个循环，看看顺序是不是对的。
    NSInteger imageCount = [self imageURLs].count;
    if (self.passByIndexArray.count < imageCount * 2)
    {
        return;
    }
    
    NSMutableArray *expectationArray = [NSMutableArray array];
    for (NSInteger i = 0; i < imageCount; i++)
    {
        [expectationArray addObject:@(i)];
    }
    [expectationArray addObjectsFromArray:expectationArray];
    
    if ([expectationArray isEqualToArray:self.passByIndexArray])
    {
        [self.testingExpectation fulfill];
    }
    else
    {
        XCTFail(@"Page Move sequence error!");
    }
}

- (void)carousel:(nonnull PSCarouselView *)carousel didTouchPage:(NSUInteger)page
{
    
}

- (void)carousel:(nonnull PSCarouselView *)carousel didDownloadImages:(nonnull UIImage *)image atPage:(NSUInteger)page
{
    
}



//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
