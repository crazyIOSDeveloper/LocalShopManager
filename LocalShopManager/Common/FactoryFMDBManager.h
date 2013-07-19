//
//  FactoryFMDBManager.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-17.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <Foundation/Foundation.h>
//与数据库相关
@interface FactoryFMDBManager : NSObject

//
+(PurchaserDataObject *)purchaseForTelNum:(NSString *)tel;


+(NSArray *)listArrayFromLocalDBWith:(Class)aclass;


@end
