//
//  PXYDeviceBatteryHelper.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/22.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "PXYDeviceBatteryHelper.h"

#import "IOPSKeys.h"
#import "IOPowerSources.h"


@implementation PXYDeviceBatteryHelper

/**
 获取当前电量的信息:百分比 80%
 
 @return 80.0
 */
+ (double)fetchBatteryLevel {
    //返回电量信息
    CFTypeRef bold = IOPSCopyPowerSourcesInfo();
    //返回电量句柄列表信息
    CFArrayRef sources = IOPSCopyPowerSourcesList(bold);
    CFDictionaryRef pSource = NULL;
    const void *psValue;
    //返回数据大小
    int numOfSources = (int)CFArrayGetCount(sources);
    if (numOfSources == 0) {
        NSLog(@"Error in CFArrayGetCount");
        return -1.0f;
    }
    
    //计算所剩的电量
    //返回电源可读信息的字典
    pSource = IOPSGetPowerSourceDescription(bold, CFArrayGetValueAtIndex(sources, 0));
    if (pSource == nil) return -1.0;
    
    psValue = (CFStringRef)CFDictionaryGetValue(pSource, CFSTR(kIOPSNameKey));
    
    int curCapacity = 0;
    int maxCapacity = 0;
    double percentage;
    
    psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSCurrentCapacityKey));
    CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &curCapacity);
    
    psValue = CFDictionaryGetValue(pSource, CFSTR(kIOPSMaxCapacityKey));
    CFNumberGetValue((CFNumberRef)psValue, kCFNumberSInt32Type, &maxCapacity);
    
    percentage = ((double)curCapacity / (double)maxCapacity * 100.f);
    NSLog(@"curCapacity: %d / maxCapacity: %d,persentage: %.1f",curCapacity,maxCapacity,percentage);
    return percentage;
}

@end
