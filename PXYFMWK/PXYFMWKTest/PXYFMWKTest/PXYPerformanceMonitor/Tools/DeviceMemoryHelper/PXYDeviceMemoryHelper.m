//
//  PXYDeviceMemoryHelper.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/30.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYDeviceMemoryHelper.h"
#import "mach/mach.h"

@implementation PXYDeviceMemoryHelper

/**
 获取已使用内存
 */
+ (long)fetchUsedMemory {
    return usedMemory();
}

/**
 获取可用内存
 */
+ (long)fetchFreeMemory {
    return freeMemory();
}

/**
 打印内存信息
 */
+ (void)fetchLogMemUsage {
    logMemUsage();
}


vm_size_t usedMemory(void) {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    return (kerr == KERN_SUCCESS) ? info.resident_size : 0; // size in bytes
}

vm_size_t freeMemory(void) {
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    (void) host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    return vm_stat.free_count * pagesize;
}

void logMemUsage(void) {
    // compute memory usage and log if different by >= 100k
    static long prevMemUsage = 0;
    long curMemUsage = usedMemory();
    long memUsageDiff = curMemUsage - prevMemUsage;
    
    if (memUsageDiff > 100000 || memUsageDiff < -100000) {
        prevMemUsage = curMemUsage;
        NSLog(@"Memory used %7.1f (%+5.0f), free %7.1f kb", curMemUsage/1024.0f, memUsageDiff/1000.0f, freeMemory()/1024.0f);
    }
}

@end
