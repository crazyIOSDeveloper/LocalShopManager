//
//  SortsTypeObject.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-2.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "WAPersistableObject.h"
//商品类型编码名称对照表


@interface SortsTypeObject : WAPersistableObject

//详细商品分类编号
@property (nonatomic,retain) NSString * detailSortId_;

//商品分类名称
@property (nonatomic,retain) NSString * sortName_;

//商品分类描述
@property (nonatomic,retain) NSString * sortTypeDSC_;


@end
