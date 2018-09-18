//
//  PXYFPSLabel.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/27.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYFPSLabel.h"
#import "PXYFPSHelper.h"
#import "PXYDeviceCpuHelper.h"
#import "PXYDeviceMemoryHelper.h"

@interface PXYFPSLabel ()

@end

@implementation PXYFPSLabel
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildData];
    }
    return self;
}

- (void)dealloc {
    [[PXYFPSHelper shareInstance] endFPSMonitoring];
}

#pragma mark - Private Methods
- (void)buildData {
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont boldSystemFontOfSize:14];
    
    [[PXYFPSHelper shareInstance] getFPSValueWithBlock:^(float fps) {
//        NSLog(@"PFS 监测");
        
        float cpuUsage = [PXYDeviceCpuHelper fetchCpuUsage];
        
        long usedMemory = [PXYDeviceMemoryHelper fetchUsedMemory];
        self.text = [NSString stringWithFormat:@"%d FPS | CPU Usage:%.2f%% | Memory Usage:%ldMB",(int)round(fps),cpuUsage,usedMemory/1024/1024];
    }];
}



@end
