//
//  NormalPerson.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-3.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "WAPersistableObject.h"
//联系人
@interface NormalPerson : WAPersistableObject

@property (nonatomic,retain) NSString * personIdStr_;
@property (nonatomic,retain) NSString * name_;
@property (nonatomic,retain) NSString * telNum_;

@property (nonatomic,retain) NSString * anOtherTelNum_;

@property (nonatomic,retain) NSString * locationDSC_;


@property (nonatomic,retain) NSString * detailIntroduce_;


@end
