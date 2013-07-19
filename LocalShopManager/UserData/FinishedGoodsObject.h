//
//  FinishedGoodsObject.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-3.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "WAPersistableObject.h"
//商品库存表，提供目前店铺物品分析统计数据
typedef enum _GoodsSellState {
	GoodsSellStateNone = 0,//未知
    GoodsSellStateAccountIn = 1,//进货
    GoodsSellStateAbsent = 2,//不在销售中
    GoodsSellStateRejected = 3,//已退换
    GoodsSellStateAccountOut = 4,//已售出
    GoodsSellStatePreRepair = 5,//收到，等待维修
    GoodsSellStateInRepair = 6,//维修中
    GoodsSellStateRepairBack = 7//维修取回
} GoodsSellState;

@interface FinishedGoodsObject : WAPersistableObject

@property (nonatomic,retain) NSString * goodsIdStr_;//商品编号
@property (nonatomic,retain) NSString * goodsPriceStr_;//商品进价
@property (nonatomic,retain) NSString * detailSortIdStr_;//种类编号，方便相关查询

@property (nonatomic,retain) NSString * accountInIdStr_;//进货编号，进货相关信息查询
@property (nonatomic,assign) int  goodsSellState_;//商品销售状态

@property (nonatomic,retain) NSString * accountOutIdStr_;//出货时间，有些货物没有此条记录

@property (nonatomic,retain) NSString * gooodsDSC_;//商品描述



@end
