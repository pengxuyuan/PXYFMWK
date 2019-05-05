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


#pragma mark - Plublic Methods
/**
 获取 App 占用的物理内存 phys_footprint
 
 @return phys_footprint
 */
+ (uint64_t)fetchAppPhysicalMmory {
    task_vm_info_data_t vmInfo = FetchTaskVmInfoDataT();
    return vmInfo.phys_footprint;
}

/**
 获取 App 占用的驻留内存 虚拟内存
 
 @return resident_size
 */
+ (uint64_t)fetchAppVirtualMemory {
    task_vm_info_data_t vmInfo = FetchTaskVmInfoDataT();
    return vmInfo.resident_size;
}

/**
 Log 内存相关信息
 */
+ (void)printMemoryInfo {
    uint64_t PhysicalMmory = [self fetchAppPhysicalMmory];
    uint64_t VirtualMemory = [self fetchAppVirtualMemory];
    
    NSLog(@"App 占用物理内存：%llu MB(%llu MB), 占用虚拟内存：%llu MB",(PhysicalMmory/1024/1024),(PhysicalMmory/1000/1000),(VirtualMemory/1024/1024));
}


#pragma mark - Privaye Methods
//task_vm_info
//struct task_vm_info {
//    mach_vm_size_t  virtual_size;       // 虚拟内存大小
//    integer_t region_count;             // 内存区域的数量
//    integer_t page_size;
//    mach_vm_size_t  resident_size;      // 驻留内存大小
//    mach_vm_size_t  resident_size_peak; // 驻留内存峰值
//
//    ...
//
//    /* added for rev1 */
//    mach_vm_size_t  phys_footprint;     // 物理内存
//
//    ...
task_vm_info_data_t FetchTaskVmInfoDataT(void) {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t result = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&vmInfo, &count);
    if (result != KERN_SUCCESS) {
//        return NULL;
    } else {
        return vmInfo;
    }

    return vmInfo;
}

vm_size_t usedMemory(void) {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t result = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t)&vmInfo, &count);
    if (result != KERN_SUCCESS) {
        return 0;
    } else {
        return vmInfo.phys_footprint;
    }
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

@end
