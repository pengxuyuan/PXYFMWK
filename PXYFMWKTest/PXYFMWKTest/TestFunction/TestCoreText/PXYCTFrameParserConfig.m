//
//  PXYCTFrameParserConfig.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/19.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "PXYCTFrameParserConfig.h"

#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]

@implementation PXYCTFrameParserConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 16.0f;
        _lineSpace = 8.0f;
        _textColor = RGB(108, 108, 108);
    }
    return self;
}

@end
