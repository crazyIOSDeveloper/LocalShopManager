//
//  AccountOutObject.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-2.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "WAPersistableObject.h"
//出货表，针对可能同时卖出两件商品的可能，totalGoodsId_，为编号串，使用,分割
#import <CoreLocation/CoreLocation.h>

@interface AccountOutObject : WAPersistableObject
{
//    CLLocationManager;
//    MKReverseGeocoder
    
}
@property (nonatomic,retain) NSString * totalGoodsId_;//商品编号
@property (nonatomic,retain) NSString * detailSortId_;//分类编号
@property (nonatomic,retain) NSString * accountPrice_;//出货价格

@property (nonatomic,retain) NSString * accountTime_;//出货时间
@property (nonatomic,retain) NSString * salesmanName_;//进货员



@end
