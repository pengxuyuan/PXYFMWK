//
//  TKModuleModel.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/4.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "TKModuleModel.h"

@implementation TKModuleModel

- (NSString *)description {
    NSString *desc = [NSString stringWithFormat:@"funcNo:%@,sourceModule:%@,targetModule:%@,params:%@",_funcNo,_sourceModule,_targetModule,_params];
    return desc;
}

@end
