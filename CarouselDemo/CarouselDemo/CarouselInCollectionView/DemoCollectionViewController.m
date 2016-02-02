//
//  DemoCollectionViewController.m
//
//  Created by Pan on 16/2/2.
//  Copyright © 2016年 Pan. All rights reserved.
//

#import "DemoCollectionViewController.h"
#import "DemoCollectionViewCell.h"
#import "Macros.h"

@interface DemoCollectionViewController ()<UICollectionViewDelegateFlowLayout>


@end

@implementation DemoCollectionViewController

#pragma mark - Public

#pragma mark - Life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - IBAction


#pragma mark - Navigation


#pragma mark - UIColelctionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[DemoCollectionViewCell description] forIndexPath:indexPath];
    cell.imageURLs = IMAGE_URLS;
    cell.speed = indexPath.item % 4 + 1;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat length = CGRectGetWidth(self.view.bounds) / 3;
    return CGSizeMake(length,length);
}
#pragma mark - Notification


#pragma mark - Private Method


#pragma mark - Getter and Setter

@end
