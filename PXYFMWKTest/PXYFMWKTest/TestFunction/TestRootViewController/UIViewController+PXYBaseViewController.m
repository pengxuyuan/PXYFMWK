//
//  UIViewController+PXYBaseViewController.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/5.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "UIViewController+PXYBaseViewController.h"
#import <objc/runtime.h>
#import "PXYViewControllerHelper.h"


@implementation UIViewController (PXYBaseViewController)


#pragma mark - Setter & Getter
- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[PXYViewControllerHelper sharedInstance] registerViewController:self withName:name];
}

- (NSString *)name {
    return objc_getAssociatedObject(self, _cmd);
}


@end
