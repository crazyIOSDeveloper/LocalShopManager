//
//  WAPersistableObject.h
//  WAEngine
//
//  Created by 郭煜 on 13-1-24.
//  Copyright (c) 2013年 中科金财电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAPersistableObject : NSObject

+ (NSString *)tableName;
+ (NSString *)createTableSQL;
+ (NSArray*)persistedFields;
+ (NSArray*)primaryKeyFields;

- (void)setValue:(id)value forPersistedField:(NSString *)persistedField;
- (id)valueForPersistedField:(NSString*)persistedField;

@end
