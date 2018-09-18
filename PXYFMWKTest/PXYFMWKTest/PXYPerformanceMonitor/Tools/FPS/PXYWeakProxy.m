//
//  PXYWeakObject.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/7/5.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYWeakProxy.h"

@interface PXYWeakProxy ()

@property (nonatomic, weak, readwrite) id target;

@end

@implementation PXYWeakProxy
#pragma mark - Life cycle
- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

#pragma mark - Public Methods
+ (instancetype)objectWithTarget:(id)target {
    return [[PXYWeakProxy alloc] initWithTarget:target];
}

#pragma mark - Private Methods Message forwarding mechanism
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _target;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [self.target methodSignatureForSelector:selector];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

#pragma mark - NSObject
- (NSString *)description {
    return [_target description];
}

- (NSString *)debugDescription {
    return [_target debugDescription];
}

- (BOOL)isEqual:(id)object {
    return [_target isEqual:object];
}

- (NSUInteger)hash {
    return [_target hash];
}

- (Class)superclass {
    return [_target superclass];
}

- (Class)class {
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

@end
