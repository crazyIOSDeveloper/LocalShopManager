//
//  PurchaserDataObject.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-3.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "NormalPerson.h"
//购买者，顾客
@interface PurchaserDataObject : NormalPerson

//登陆密码
@property (nonatomic,retain) NSString * loginPWD;

//校验码，黑屏后再进入的验证码
@property (nonatomic,retain) NSString * checkNum;

@property (nonatomic,retain) NSString * relativeDSC_;//相关描述


@end
