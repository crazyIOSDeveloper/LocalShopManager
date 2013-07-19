//
//  FactoryController.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-16.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <Foundation/Foundation.h>
//工厂类，生产不同的controller


@interface FactoryController : NSObject

//登陆controller
+(UIViewController *)loginInControllerWithSender:(id)sender;

//注册界面Controller
+(UIViewController *)registControllerWithSender:(id)sender;

//忘记密码controller
+(UIViewController *)checkPWDControllerWithSender:(id)sender;

//类型选择界面controller
+(UIViewController *)chooseTypeContrllerWithSender:(id)sender;








@end
