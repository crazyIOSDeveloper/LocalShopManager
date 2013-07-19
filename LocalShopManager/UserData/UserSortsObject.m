//
//  UserSortsObject.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-2.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "UserSortsObject.h"

@implementation UserSortsObject
@synthesize personIdStr_;
@synthesize sortsShopId_;
@synthesize sortsStruct_;
@synthesize lastDate_;

+ (NSString *)tableName
{
    return @"shop_sorts";
}

+ (NSString *)createTableSQL
{
    NSString  *makeSQL = @"PRAGMA encoding=\"UTF-8\"\n"
    "CREATE TABLE shop_sorts(shopId TEXT PRIMARY KEY, "
    "personId TEXT, "
    "sortStruct TEXT, "
    "updateTime TEXT)";
    return makeSQL;
}
+ (NSArray*)persistedFields
{
    return @[@"shopId",
             @"personId",
             @"sortStruct",
             @"updateTime"];
}

+ (NSArray*)primaryKeyFields
{
    return @[@"shopId"];
}

- (void)setValue:(id)value forPersistedField:(NSString *)persistedField
{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    else if ([persistedField isEqualToString:@"shopId"]) {
        [self setSortsShopId_:value];
    }
    else if ([persistedField isEqualToString:@"personId"])
    {
        [self setPersonIdStr_:value];
    }
    else if ([persistedField isEqualToString:@"sortStruct"]) {
        [self setSortsStruct_:value];
    }
    else if ([persistedField isEqualToString:@"updateTime"]) {
        [self setLastDate_:value];
    }
}



- (id)valueForPersistedField:(NSString *)persistedField
{
    id retValue = nil;
    if ([persistedField isEqualToString:@"shopId"]) {
        if (self.sortsShopId_)
        {
            retValue = self.sortsShopId_;
        }
    }
    else if ([persistedField isEqualToString:@"sortStruct"]) {
        if (self.sortsStruct_) {
            retValue = self.sortsStruct_;
        }
    }
    else if ([persistedField isEqualToString:@"personId"]) {
        if (self.personIdStr_) {
            retValue = self.personIdStr_;
        }
    }
    else if ([persistedField isEqualToString:@"updateTime"]) {
        if (self.lastDate_) {
            retValue = self.lastDate_;
        }
    }
    else {
    }
    
    if (nil == retValue) {
        retValue = [NSNull null];
    }
    return retValue;
}






@end
