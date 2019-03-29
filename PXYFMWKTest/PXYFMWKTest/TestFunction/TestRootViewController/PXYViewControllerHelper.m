//
//  PXYViewControllerHelper.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/5.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "PXYViewControllerHelper.h"

#define LOCK(semaphore) dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
#define UNLOCK(semaphore) dispatch_semaphore_signal(semaphore)

@interface PXYViewControllerHelper()

@property (nonatomic, strong) NSMapTable <NSString *, id>*viewControllerMap;
@property (nonatomic, strong) dispatch_semaphore_t mapSemaphore_t;

@end


@implementation PXYViewControllerHelper

#pragma mark - Life Cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static PXYViewControllerHelper *instance;
    dispatch_once(&onceToken, ^{
        instance = [PXYViewControllerHelper new];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.viewControllerMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
        self.mapSemaphore_t = dispatch_semaphore_create(1);
    }
    return self;
}


// 将控制器和name 注册到全局 Map 中
- (void)registerViewController:(UIViewController *)viewController withName:(NSString *)name {
    if (viewController == nil || name.length == 0) return;
    
    LOCK(self.mapSemaphore_t);
    [self.viewControllerMap setObject:viewController forKey:name];
    UNLOCK(self.mapSemaphore_t);
}

//通过 name 获取控制器
- (UIViewController *)fetchViewControllerWithName:(NSString *)name {
    if (name.length == 0) return nil;
    
    UIViewController *viewController;
    LOCK(self.mapSemaphore_t);
    viewController = [self.viewControllerMap objectForKey:name];
    UNLOCK(self.mapSemaphore_t);
    return viewController;
}

//注销全部注册的控制器
- (void)removeAllRegisterViewController {
    LOCK(self.mapSemaphore_t);
    [self.viewControllerMap removeAllObjects];
    UNLOCK(self.mapSemaphore_t);
}




@end
