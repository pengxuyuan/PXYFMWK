//
//  PXYDesHelper.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/11.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 DES 帮助类
 */
@interface PXYDesHelper : NSObject

/**
 *  Des加密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithDesEncryptString:(NSString *)string withKey:(NSString *)key;

/**
 *  Des加密
 *
 *  @param data 数据
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithDesEncryptData:(NSData *)data withKey:(NSString *)key;

/**
 *  Des加密,先加密，再做base64编码
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 加密后的字符串
 */
+(NSString *)stringWithDesEncryptString:(NSString *)string withKey:(NSString *)key;

@end
