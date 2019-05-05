//
//  PXYThreadHelper.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/22.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "PXYThreadHelper.h"

#import <mach/mach.h>

@implementation PXYThreadHelper

/**
 轮询检查多个线程 CPU 使用情况
 */
+ (void)checkThreadCPU {
    thread_act_array_t threads;
    mach_msg_type_number_t threadCount = 0;
    const task_t thisTask = mach_task_self();
    kern_return_t kr = task_threads(thisTask, &threads, &threadCount);
    if (kr != KERN_SUCCESS) {
        return;
    }
    
    for (int i = 0; i < threadCount; i ++) {
        thread_info_data_t threadInfo;
        thread_basic_info_t threadBaseInfo;
        
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        if (thread_info((thread_act_t)threads[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount) == KERN_SUCCESS) {
            threadBaseInfo = (thread_basic_info_t)threadInfo;
            if ((threadBaseInfo->flags & TH_FLAGS_GLOBAL_FORCED_IDLE)) {
                integer_t cpuUsage = threadBaseInfo->cpu_usage / 10;
                if (cpuUsage > 70) {
                    //CPU 消耗大于 70时，打印和记录堆栈
//                    NSString *reStr = smStackOfThread(threads[i]);
                    NSLog(@"CPU 使用率消耗过大线程：\n%@",@"");
                }
            }
            
        }
    }
}

@end
