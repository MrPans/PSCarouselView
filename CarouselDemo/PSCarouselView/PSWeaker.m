//
//  PSWeaker.m
//  CarouselDemo
//
//  Created by Pan on 16/6/1.
//  Copyright © 2016年 Pan. All rights reserved.
//

#import "PSWeaker.h"

@interface PSWeaker ()

@property (nonatomic, weak) id target;


@end

@implementation PSWeaker

- (instancetype)initWithObject:(id)object
{
    self = [super init];
    if (self)
    {
        _target = object;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithObject:nil];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.target;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
@end
