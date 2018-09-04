//
//  PXYAPMLoadMonitor.m
//  PXYFMWK
//
//  Created by Pengxuyuan on 2018/9/3.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "PXYAPMLoadMonitor.h"
#import "NSObject+PXYRuntimeHelper.h"

#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>
#include <limits.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>
#include <string.h>

#define TIMESTAMP_NUMBER(interval)  [NSNumber numberWithLongLong:interval*1000]

#define kStartTime @"kStartTime"
#define kEndTime @"kEndTime"
#define kSpendTime @"kSpendTime"
#define kClassName @"kClassName"

unsigned int count;
const char **classes;

static NSMutableArray *PXYAPM_LoadInfoArray;

@interface PXYAPMLoadMonitor ()

@end

@implementation PXYAPMLoadMonitor

+ (void)load {
    NSLog(@"%s",__func__);
    PXYAPM_LoadInfoArray = [[NSMutableArray alloc] init];
    
    CFAbsoluteTime time1 =CFAbsoluteTimeGetCurrent();
    
    int imageCount = (int)_dyld_image_count();
    
    for(int iImg = 0; iImg < imageCount; iImg++) {
        
        const char* path = _dyld_get_image_name((unsigned)iImg);
        NSString *imagePath = [NSString stringWithUTF8String:path];
        
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSString* bundlePath = [mainBundle bundlePath];
        
        if ([imagePath containsString:bundlePath] && ![imagePath containsString:@".dylib"]) {
            classes = objc_copyClassNamesForImage(path, &count);
            
            for (int i = 0; i < count; i++) {
                NSString *className = [NSString stringWithCString:classes[i] encoding:NSUTF8StringEncoding];
                if (![className isEqualToString:@""] && className) {
                    Class class = object_getClass(NSClassFromString(className));
                    
                    SEL originalSelector = @selector(load);
                    SEL swizzledSelector = @selector(PXYAPM_Load);
                    
                    [self pxy_swizzleMethodWithOriginalClass:class originalSelector:originalSelector swizzledClass:[PXYAPMLoadMonitor class] swizzledSelector:swizzledSelector isInstanceMethod:NO];
                }
            }
        }
    }
    
    CFAbsoluteTime time2 =CFAbsoluteTimeGetCurrent();
    
    NSLog(@"Hook Time---:%.3f 秒",(time2 - time1));
}

+ (void)PXYAPM_Load {
    CFAbsoluteTime start =CFAbsoluteTimeGetCurrent();
    
    [self PXYAPM_Load];
    
    CFAbsoluteTime end =CFAbsoluteTimeGetCurrent();
    
    // 时间精度 ms
    NSDictionary *infoDic = @{kStartTime:TIMESTAMP_NUMBER(start),
                              kEndTime:TIMESTAMP_NUMBER(end),
                              kClassName:NSStringFromClass([self class]),
                              kSpendTime:TIMESTAMP_NUMBER((end - start))
                              };
    
    [PXYAPM_LoadInfoArray addObject:infoDic];
}

/**
 打印 Load 函数消耗的时间
 */
+ (void)pxy_printLoadTimeConsuming {
    double totalSpendTime = 0;
    for (NSDictionary *infoDict in PXYAPM_LoadInfoArray) {
        NSNumber *spendTime = infoDict[kSpendTime];
        NSString *className = infoDict[kClassName];
        
        NSLog(@"类：%@ Load 方法耗时：%.3f ms",className,[spendTime doubleValue]);
        totalSpendTime += [spendTime doubleValue];
    }
    NSLog(@"Load 方法总共耗时：%.3f ms",totalSpendTime);
}



@end
