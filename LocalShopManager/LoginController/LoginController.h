//
//  LoginController.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CheckPWDController.h"
#import "DBSignupViewController.h"
#import "QQViewController.h"

@interface LoginController : UIViewController
{
    
}
@property (nonatomic,retain) NSString * loginName;
@property (nonatomic,retain) NSString * loginTel;
@property (nonatomic,retain) NSString * loginImgPath;
@property (nonatomic,retain) NSString * loginCheck;

+(LoginController *)sharedLoginController;

-(void)quitUserLogin:(id)sender;
//用户退出登陆
-(NSDictionary *)saveNowLoginUserDataToDefault;
//保存当前用户数据至 default

+(UIViewController *)controllerForLogin:(id)sender;
+(UIViewController *)controllerForRegist:(id)sender;
+(UIViewController *)controllerForCheckPWD:(id)sender;

@end
