//
//  PXYCTFrameParserConfig.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/19.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用于配置绘制的参数，例如文字颜色，大小，间距
 */
@interface PXYCTFrameParserConfig : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor;


@end

NS_ASSUME_NONNULL_END
