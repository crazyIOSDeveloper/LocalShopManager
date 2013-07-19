//
//  UserSortsObject.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-2.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "WAPersistableObject.h"
//用户、商品分类存储表


@interface UserSortsObject : WAPersistableObject

//用户名
@property (nonatomic,retain) NSString * personIdStr_;


//商品分类商店编号
@property (nonatomic,retain) NSString * sortsShopId_;


//商品分类结构
@property (nonatomic,retain) NSString * sortsStruct_;


//修改时间
@property (nonatomic,retain) NSString * lastDate_;





@end
