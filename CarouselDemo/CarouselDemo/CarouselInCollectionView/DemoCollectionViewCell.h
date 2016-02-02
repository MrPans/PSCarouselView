/*! 

  @header DemoCollectionViewCell.h

  @abstract DemoCollectionViewCell

  @author Created by Pan on 16/2/2.

  @version 1.0.5 16/2/2 Creation

  Copyright © 2016年 Pan. All rights reserved.

 */

#import <UIKit/UIKit.h>

/*!
 
  @class DemoCollectionViewCell
 
  @abstract DemoCollectionViewCell
 
 */
@interface DemoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSArray<NSURL *> *imageURLs;
@property (nonatomic, assign) NSTimeInterval speed;

@end
