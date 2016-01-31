//
//  DemoTableViewController.m
//  CarouselDemo
//
//  Created by Pan on 16/1/21.
//  Copyright © 2016年 Pan. All rights reserved.
//

#import "DemoTableViewController.h"
#import "CarouselCell.h"
#import "Macros.h"

#define CAROUSEL_SECTION 0
#define NORMARL_SECTION 1

@interface DemoTableViewController ()

@property (nonatomic, strong) NSMutableArray<NSString *> *dataSource;

@end

@implementation DemoTableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == CAROUSEL_SECTION ? 1 : self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == CAROUSEL_SECTION)
    {
        CarouselCell *cell = [tableView dequeueReusableCellWithIdentifier:[CarouselCell description]
                                                             forIndexPath:indexPath];
        cell.imageURLs = IMAGE_URLS;
        return cell;
    }
    else if (indexPath.section == NORMARL_SECTION)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell description]
                                                                forIndexPath:indexPath];
        cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark - Getter && Setter
- (NSMutableArray<NSString *> *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
        for (NSInteger i = 0; i < 20; i++)
        {
            [_dataSource addObject:@(i).stringValue];
        }
    }
    return _dataSource;
}

@end
