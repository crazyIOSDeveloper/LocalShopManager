//
//  FactoryFMDBManager.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-17.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "FactoryFMDBManager.h"

@implementation FactoryFMDBManager
+(PurchaserDataObject *)purchaseForTelNum:(NSString *)tel
{
    LocalDBDataManager * manager = [LocalDBDataManager defaultManager];
    NSString *where = [NSString stringWithFormat:@"user_id='%@'", tel];
    NSArray * array = [manager selectObjects:[PurchaserDataObject class] where:where];
    for (PurchaserDataObject * obj in array )
    {
        if ([obj.personIdStr_ isEqualToString:tel])
        {
            return obj;
        }
    }
    return nil;
}

+(NSArray *)listArrayFromLocalDBWith:(Class)aclass
{
    LocalDBDataManager * manager = [LocalDBDataManager defaultManager];
    NSArray * array = [manager selectObjects:aclass where:nil];
    
    return array;
}


@end
