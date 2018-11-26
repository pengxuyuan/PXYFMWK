//
//  PXYBase64Helper.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/12.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Base64 编码
 */
@interface PXYBase64Helper : NSObject

/**
 String 进行 Base64 编码，转成 NSString
 */
+ (NSString *)stringEncodeBase64WithString:(NSString *)string;

/**
 String 进行 Base64 解码，转成 NSString
 */
+ (NSString *)stringDecodeBase64WithString:(NSString *)string;

/**
 NSData 进行 Base64 编码,转成 NSString
 */
+ (NSString *)stringEncodeBase64WithData:(NSData *)data;

/**
 NSData 进行 Base64 解码，转成 NSString
 */
+ (NSString *)stringDecodeBase64WithData:(NSData *)data;

/**
 NSData 进行 Base64 编码，转成 Data
 */
+ (NSData *)dataEncodeBase64WithData:(NSData *)data;

/**
 NSData 进行 Base64 解码，转成 Data
 */
+ (NSData *)dataDecodeBase64WithData:(NSData *)data;

@end
