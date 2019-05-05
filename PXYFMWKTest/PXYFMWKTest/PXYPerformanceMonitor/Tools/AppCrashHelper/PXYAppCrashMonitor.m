//
//  PXYAppCrashMonitor.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/24.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "PXYAppCrashMonitor.h"

@interface PXYAppCrashMonitor()

@end

@implementation PXYAppCrashMonitor

void registerSignalHandler(void) {
    signal(SIGSEGV, handleSignalException);
    signal(SIGFPE, handleSignalException);
    signal(SIGBUS, handleSignalException);
    signal(SIGPIPE, handleSignalException);
    signal(SIGHUP, handleSignalException);
    signal(SIGINT, handleSignalException);
    signal(SIGQUIT, handleSignalException);
    signal(SIGABRT, handleSignalException);
    signal(SIGILL, handleSignalException);
}

void handleSignalException (int signal) {
//    NSMutableString *crashString = [NSMutableString string];
//    void *callStack[128];
//    int i, frames = backtrace(callStack, 128);
//    char **traceChar = backtrace_symbols(callStack, frames);
//    for (int i = 0; i < frames; i ++) {
//        [crashString appendFormat:@"%s\n", traceChar[i]];
//    }
//    NSLog(crashString);
}


@end
