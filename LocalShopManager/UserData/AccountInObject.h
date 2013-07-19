//
//  AccountInObject.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-2.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "WAPersistableObject.h"
//进货表


@interface AccountInObject : WAPersistableObject

@property (nonatomic,retain) NSString * totalGoodsId_;//商品编号
@property (nonatomic,retain) NSString * detailSortId_;//分类编号
@property (nonatomic,retain) NSString * accountPrice_;//进货价格

@property (nonatomic,retain) NSString * accountTime_;//进货时间
@property (nonatomic,retain) NSString * receiverName_;//进货员

@property (nonatomic,retain) NSString * sellerIdStr_;//推销人员


@end
