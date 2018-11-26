//
//  NSData+PXYFileType.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/19.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 利用魔数来标示文件类型
 */
@interface NSData (PXYFileType)

+ (void)fileFormatForFileData:(nullable NSData *)data;

@end
