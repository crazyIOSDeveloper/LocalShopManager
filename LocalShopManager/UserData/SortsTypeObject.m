//
//  SortsTypeObject.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-2.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "SortsTypeObject.h"

@implementation SortsTypeObject
@synthesize detailSortId_;
@synthesize sortName_;
@synthesize sortTypeDSC_;


+ (NSString *)tableName
{
    return @"sorts_detail";
}


+ (NSArray*)persistedFields
{
    return @[@"sortDetailId",
             @"sortName",
             @"sortDSC"];
}

+ (NSArray*)primaryKeyFields
{
    return @[@"sortDetailId"];
}

- (void)setValue:(id)value forPersistedField:(NSString *)persistedField
{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    else if ([persistedField isEqualToString:@"sortDetailId"]) {
        [self setDetailSortId_:value];
    }
    else if ([persistedField isEqualToString:@"sortName"]) {
        [self setSortName_:value];
    }
    else if ([persistedField isEqualToString:@"sortDSC"]) {
        [self setSortTypeDSC_:value];
    }
}



- (id)valueForPersistedField:(NSString *)persistedField
{
    id retValue = nil;
    if ([persistedField isEqualToString:@"sortDetailId"]) {
        if (self.detailSortId_) {
            retValue = self.detailSortId_;
        }
    }
    else if ([persistedField isEqualToString:@"sortName"]) {
        if (self.sortName_) {
            retValue = self.sortName_;
        }
    }
    else if ([persistedField isEqualToString:@"sortDSC"]) {
        if (self.sortTypeDSC_) {
            retValue = self.sortTypeDSC_;
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