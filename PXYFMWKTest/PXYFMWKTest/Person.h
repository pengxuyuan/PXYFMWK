//
//  Person.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/18.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) void(^block)();


@end

NS_ASSUME_NONNULL_END
