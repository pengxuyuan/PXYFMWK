//
//  PXYApplication.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/17.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "PXYApplication.h"

@implementation PXYApplication

- (void)sendEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
    [super sendEvent:event];
}

@end
