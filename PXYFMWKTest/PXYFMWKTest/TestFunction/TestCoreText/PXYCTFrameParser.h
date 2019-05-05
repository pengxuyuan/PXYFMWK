//
//  PXYCTFrameParser.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/19.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PXYCTTextData.h"
#import "PXYCTFrameParserConfig.h"

NS_ASSUME_NONNULL_BEGIN

/**
 用于生成最后绘制界面需要的 CTFrameRef 实例
 */
@interface PXYCTFrameParser : NSObject

+ (PXYCTTextData *)parseContent:(NSString *)content config:(PXYCTFrameParserConfig *)config;

@end

NS_ASSUME_NONNULL_END
