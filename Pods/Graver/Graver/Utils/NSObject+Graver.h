//
//  NSObject+Graver.h
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
    

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Graver)
/**
 * 根据指定可以获取对象关联的一个属性
 *
 * @param key 关联对象的key
 *
 * @return key对应的关联对象
 */
- (id)wmg_objectWithAssociatedKey:(void *)key;

/**
 * 给一个对象按照指定策略关联一个对象
 *
 * @param object 待关联对象
 * @param key 关联对象指定的key
 * @param policy 关联策略
 *
 */
- (void)wmg_setObject:(id)object forAssociatedKey:(void *)key associationPolicy:(objc_AssociationPolicy)policy;

@end

NS_ASSUME_NONNULL_END
