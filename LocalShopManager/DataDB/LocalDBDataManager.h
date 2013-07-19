//
//  LocalDBDataManager.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-2.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAPersistableObject.h"



@interface LocalDBDataManager : NSObject
{
    
}
@property (nonatomic, copy, readonly) NSString* localPath;

+ (id)defaultManager;
- (id)initWithLocalPath:(NSString*)localPath;

- (NSArray*)selectObjects:(Class)persistableObjectClass where:(NSString*)where;
- (BOOL)updateObject:(WAPersistableObject*)persistableObject where:(NSString*)where;
- (BOOL)insertObject:(WAPersistableObject*)persistableObject;
- (BOOL)deleteObject:(WAPersistableObject*)persistableObject;

- (BOOL) isTableOK:(NSString *)tableName;

@end
