//
//  PXYMulticaseDelegate.m
//  PXYMulticaseDelegate
//
//  Created by Pengxuyuan on 2017/7/18.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYMulticastDelegate.h"
#import "NSObject+PXYKVO.h"

@interface PXYMulticastDelegateNode : NSObject

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) dispatch_queue_t delegateQueue;

- (instancetype)initNodeWithDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

@end

@implementation PXYMulticastDelegateNode

- (instancetype)initNodeWithDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.delegateQueue = delegateQueue;
    }
    return self;
}

@end

@interface PXYMulticastDelegate ()

//@property (nonatomic, strong) NSHashTable *observers;
@property (nonatomic, strong) NSMutableArray *observers;

@end

@implementation PXYMulticastDelegate

#pragma mark - Life Cycle
- (instancetype)init {
    _observers = [NSMutableArray array];
    
    return self;
}

#pragma mark - PublicMethods
- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    if (delegate == nil) return;
    if (delegateQueue == nil) delegateQueue = dispatch_get_main_queue();
    
    PXYMulticastDelegateNode *node = [[PXYMulticastDelegateNode alloc] initNodeWithDelegate:delegate delegateQueue:delegateQueue];
    [_observers addObject:node];
}

- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue {
    if (delegate == nil) return;
    if (delegateQueue == nil) delegateQueue = dispatch_get_main_queue();
    
    PXYMulticastDelegateNode *node = [[PXYMulticastDelegateNode alloc] initNodeWithDelegate:delegate delegateQueue:delegateQueue];
    [_observers removeObject:node];
}

- (void)removeDelegate:(id)delegate {
    [self removeDelegate:delegate delegateQueue:nil];
}

- (void)removeAllDelegate {
    [_observers removeAllObjects];
}

#pragma mark - Private Methods
- (void)doNothing {
    NSLog(@"%s",__func__);
}

#pragma mark - 蹦床模式 消息转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector  {
    for (PXYMulticastDelegateNode *node in _observers) {
        id nodeDelegate = node.delegate;
        NSMethodSignature *result = [nodeDelegate methodSignatureForSelector:aSelector];
        if (result != nil) {
            return result;
        }
    }
    
//    return [super methodSignatureForSelector:aSelector];
    return [[self class] methodSignatureForSelector:@selector(doNothing)];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    
    for (PXYMulticastDelegateNode *node in _observers) {
        id nodeDelegate = node.delegate;
        dispatch_queue_t delegateQueue = node.delegateQueue;
        if ([nodeDelegate respondsToSelector:selector]) {
            dispatch_async(delegateQueue, ^{
                [anInvocation invokeWithTarget:nodeDelegate];
            });
        }
    }
}






@end
