//
//  WAPersistableObject.m
//  WAEngine
//
//  Created by 郭煜 on 13-1-24.
//  Copyright (c) 2013年 中科金财电子商务有限公司. All rights reserved.
//

#import "WAPersistableObject.h"
#import <objc/runtime.h>

//
//  CoreAnimationEffect.h
//  CoreAnimationEffect
//
//  Created by VincentXue on 13-1-19.
//  Copyright (c) 2013年 VincentXue. All rights reserved.
//

#import <Foundation/Foundation.h>



@implementation WAPersistableObject

+ (NSString *)tableName
{
    return nil;
}

+ (NSString *)createTableSQL
{
    return nil;
}

+ (NSArray*)persistedFields
{
    return nil;
}

+ (NSArray*)primaryKeyFields
{
    return nil;
}

- (void)setValue:(id)value forPersistedField:(NSString *)persistedField
{
}

- (id)valueForPersistedField:(NSString*)persistedField
{
    return nil;
}

@end
