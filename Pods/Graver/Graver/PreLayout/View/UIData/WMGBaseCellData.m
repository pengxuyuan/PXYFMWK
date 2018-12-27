//
//  WMGBaseCellData.m
//  Graver-Meituan-Waimai
//
//  Created by yangyang
//
//  Copyright © 2018-present, Beijing Sankuai Online Technology Co.,Ltd (Meituan).  All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
    

#import "WMGBaseCellData.h"

@implementation WMGBaseCellData

- (Class)cellClass
{
    NSString *cell = [NSStringFromClass([self class]) substringWithRange:NSMakeRange(0, NSStringFromClass([self class]).length - 4)];
    return NSClassFromString(cell);
}

@end
