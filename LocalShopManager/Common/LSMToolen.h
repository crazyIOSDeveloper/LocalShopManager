//
//  LSMToolen.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LocalDBDataManager.h"

@interface LSMToolen : NSObject

+(void)noticeWithText:(NSString *)text;

+(NSString *)imgPathForApp:(id)sender;

+(UIImage *)imageFromSavePath:(NSString *)path;

//打印子视图
+(void)showSubViewsOfView:(UIView *)aView;


@end
