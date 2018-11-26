//
//  PXYStartupTimeMonitor.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/27.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "PXYStartupTimeMonitor.h"
#import <UIKit/UIKit.h>

@interface PXYStartupTimeMonitor()

@property (nonatomic, assign) CFAbsoluteTime startTime;
@property (nonatomic, assign) __block CFAbsoluteTime stopTime;
@property (nonatomic, assign) CFAbsoluteTime tagTime;

@property (nonatomic, strong) NSMutableArray <NSDictionary <NSString *, NSNumber *> *> *timeRecordArray;

@end

@implementation PXYStartupTimeMonitor

#pragma mark - Life Cycyle
/**
 单例
 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static PXYStartupTimeMonitor *instance;
    dispatch_once(&onceToken, ^{
        instance = [PXYStartupTimeMonitor new];
        instance.timeRecordArray = [NSMutableArray array];
    });
    return instance;
}

#pragma mark - Plublic Methods
/**
 App 开始记录时间
 */
- (void)appStartRecordingTime {
    _startTime = CFAbsoluteTimeGetCurrent();
}

/**
 App 打一个点
 
 @param description 当前点描述
 */
- (void)appMarkTimeWithDescription:(NSString *)description {
    CFAbsoluteTime temporaryTime = CFAbsoluteTimeGetCurrent();
    CFAbsoluteTime deltaTime;
    if (self.tagTime) {
        deltaTime = temporaryTime - self.tagTime;
    } else {
        deltaTime = temporaryTime - self.startTime;
    }
    
    
    NSDictionary *timeReordDict = @{description : @(deltaTime)};
    [self.timeRecordArray addObject:timeReordDict];
    
    self.tagTime = temporaryTime;
}

/**
 App 结束记录时间，并且 Alert 输出时间消耗
 */
- (void)appEndRecordingTimeAndShowAlert {
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.stopTime = CFAbsoluteTimeGetCurrent();
        
        NSMutableString *recordStr = [NSMutableString string];
        for (NSDictionary *dict in self.timeRecordArray) {
            NSString *recordKey = [[dict allKeys] firstObject];
            double recordValue = [[dict objectForKey:recordKey] doubleValue];
            
            [recordStr appendFormat:@"%@", [NSString stringWithFormat:@"%@:%.2f秒\n",recordKey, recordValue]];
        }
       
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[[UIAlertView alloc] initWithTitle:@"PXYStartupTimeMonitor 结果"
                                    message:recordStr
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
        [self stopRecordingTime];
#pragma clang disagnostic pop
        
    });
}

#pragma mark - Private Methods
- (void)stopRecordingTime {
    [self.timeRecordArray removeAllObjects];
    self.tagTime = 0;
}

@end


