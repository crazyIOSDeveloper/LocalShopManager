//
//  PurchaserDataObject.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-3.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "PurchaserDataObject.h"

@implementation PurchaserDataObject
@synthesize relativeDSC_;
@synthesize loginPWD;
@synthesize checkNum;

+ (NSString *)tableName
{
    return @"user_purchasers";
}

+ (NSString *)createTableSQL
{
    NSString  *makeSQL = @"PRAGMA encoding=\"UTF-8\"\n"
    "CREATE TABLE user_purchasers(user_id TEXT PRIMARY KEY, "
    "user_name TEXT, "
    "user_pwd TEXT, "
    "user_checkNum TEXT, "
    "user_telNum TEXT, "
    "user_anotherTel TEXT, "
    "user_locationDES TEXT, "
    "user_detailIntroduce TEXT,"
    "user_imgPath TEXT)";
    return makeSQL;
}

+ (NSArray*)persistedFields
{
    return @[@"user_id",
             @"user_name",
             @"user_pwd",
             @"user_checkNum",
             @"user_telNum",
             @"user_anotherTel",
             @"user_locationDES",
             @"user_detailIntroduce",
             @"user_imgPath"];
}

- (void)setValue:(id)value forPersistedField:(NSString *)persistedField
{
    if ([value isKindOfClass:[NSNull class]]) {
        return;
    }
    else if ([persistedField isEqualToString:@"user_id"]) {
        [self setPersonIdStr_:value];
    }
    else if ([persistedField isEqualToString:@"user_name"]) {
        [self setName_:value];
    }
    else if ([persistedField isEqualToString:@"user_pwd"]) {
        [self setLoginPWD:value];
    }else if ([persistedField isEqualToString:@"user_checkNum"]) {
        [self setCheckNum:value];
    }else if ([persistedField isEqualToString:@"user_telNum"]) {
        [self setTelNum_:value];
    }else if ([persistedField isEqualToString:@"user_anotherTel"])
    {
        [self setAnOtherTelNum_:value];
    }else if ([persistedField isEqualToString:@"user_locationDES"])
    {
        [self setLocationDSC_:value];
    }else if ([persistedField isEqualToString:@"user_detailIntroduce"]) {
        [self setDetailIntroduce_:value];
    }else if ([persistedField isEqualToString:@"user_imgPath"])
    {
        [self setRelativeDSC_:value];
    }
}

- (id)valueForPersistedField:(NSString *)persistedField
{
    id retValue = nil;
    
    if ([persistedField isEqualToString:@"user_id"]) {
        if (self.personIdStr_)
        {
            retValue = self.personIdStr_;
        }
    }
    else if ([persistedField isEqualToString:@"user_name"]) {
        retValue = self.name_;
    }
    else if ([persistedField isEqualToString:@"user_pwd"]) {
        retValue = self.loginPWD;
        
    }else if ([persistedField isEqualToString:@"user_checkNum"]) {
        retValue = self.checkNum;
    }else if ([persistedField isEqualToString:@"user_telNum"]) {
        retValue = self.telNum_;
    }else if ([persistedField isEqualToString:@"user_anotherTel"])
    {
        retValue = self.anOtherTelNum_;
    }else if ([persistedField isEqualToString:@"user_locationDES"])
    {
        retValue = self.locationDSC_;
    }else if ([persistedField isEqualToString:@"user_detailIntroduce"]) {
        retValue = self.detailIntroduce_;
    }else if ([persistedField isEqualToString:@"user_imgPath"])
    {
        retValue = self.relativeDSC_;
    }
    
    
    if (nil == retValue) {
        retValue = [NSNull null];
    }
    return retValue;
}




@end
