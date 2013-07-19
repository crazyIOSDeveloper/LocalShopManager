//
//  FactoryController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-16.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "FactoryController.h"

#import "CheckPWDController.h"
#import "DBSignupViewController.h"
#import "QQViewController.h"
#import "TypeChooseController.h"
@implementation FactoryController

//登陆controller
+(UIViewController *)loginInControllerWithSender:(id)sender
{
    QQViewController * qq = [[QQViewController alloc] init];
    return [qq autorelease];
}

//注册界面Controller
+(UIViewController *)registControllerWithSender:(id)sender
{
    DBSignupViewController * sign = [[DBSignupViewController alloc] init];
    return [sign autorelease];

}

//忘记密码controller
+(UIViewController *)checkPWDControllerWithSender:(id)sender
{
    CheckPWDController * check = [[CheckPWDController alloc] init];
    return [check autorelease];
}

//类型选择界面controller
+(UIViewController *)chooseTypeContrllerWithSender:(id)sender
{
    TypeChooseController * choose = [[TypeChooseController alloc] init];
    return [choose autorelease];
}

@end
