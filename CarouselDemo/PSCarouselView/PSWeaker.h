//
//  PSWeaker.h
//  CarouselDemo
//
//  Created by Pan on 16/6/1.
//  Copyright © 2016年 Pan. All rights reserved.
//

#import <Foundation/Foundation.h>


/** 
 * 本类用于解决某些系统类造成的循环引用问题，比如说NSTimer。
 */
@interface PSWeaker : NSObject

/**
 *  初始化一个weaker，并弱引用被传入的对象
 *  @param object 需要被弱引用的对象
 *  @return 一个弱引用了指定对象的Weaker。
 */
- (instancetype)initWithObject:(id)object NS_DESIGNATED_INITIALIZER;

@end
