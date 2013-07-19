//
//  LoginController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "LoginController.h"
@interface LoginController ()

@end

@implementation LoginController
@synthesize loginImgPath;
@synthesize loginName;
@synthesize loginTel;
@synthesize loginCheck;

static LoginController * _LoginController = nil;
+(LoginController *)sharedLoginController
{
    if (!_LoginController)
    {
        _LoginController = [[LoginController alloc] init];
    }
    return _LoginController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//用户退出登陆
-(void)quitUserLogin:(id)sender
{
    self.loginName = nil;
    self.loginImgPath = nil;
    self.loginTel = nil;
    self.loginCheck = nil;
    
    //发送welcome回收的消息通知
    NSNotification * notice = [NSNotification notificationWithName:LoginUserStateChangeNotifice object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:LoginUserDic];
}

//保存当前用户数据至 default
-(NSDictionary *)saveNowLoginUserDataToDefault
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if (self.loginName)
    {
        [dic setValue:loginName forKey:@"userName"];
    }
    if (self.loginImgPath)
    {
        [dic setValue:loginImgPath forKey:@"userImgPath"];
    }
    if (self.loginTel)
    {
        [dic setValue:loginTel forKey:@"userTel"];
    }
    [user setValue:dic forKey:LoginUserDic];
    
    NSNotification * notice = [NSNotification notificationWithName:LoginUserStateChangeNotifice object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    return dic;
}

+(UIViewController *)controllerForLogin:(id)sender
{
    QQViewController * qq = [[QQViewController alloc] init];
    return [qq autorelease];
}
+(UIViewController *)controllerForRegist:(id)sender
{
    DBSignupViewController * sign = [[DBSignupViewController alloc] init];
    return [sign autorelease];
}
+(UIViewController *)controllerForCheckPWD:(id)sender
{
    CheckPWDController * check = [[CheckPWDController alloc] init];
    return [check autorelease];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
