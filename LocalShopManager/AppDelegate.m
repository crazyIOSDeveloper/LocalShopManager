//
//  AppDelegate.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-6-30.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "LeftSideViewController.h"
#import "IIViewDeckController.h"
#import "UIView+Size.h"
#import <ShareSDK/ShareSDK.h>
#import "AWVersionAgent.h"
#import "RightSideViewController.h"
#import "WeakUpViewController.h"
#import "LoginController.h"
@implementation AppDelegate
@synthesize viewController;
@synthesize interfaceOrientationMask;
- (void)dealloc
{
    [navigation release];
    [_window release];
    [super dealloc];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"]];
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    

    
    [[AWVersionAgent sharedAgent] setDebug:YES];
    [[AWVersionAgent sharedAgent] checkNewVersionForApp:@"433602054"];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    self.window.backgroundColor = [UIColor redColor];
    self.window.backgroundColor = [UIColor colorWithRGB:0xe1e0de];
    navigation = [[HomeNavigationDelegate alloc] init];
    
    
    //主视图
    UIViewController *apiVC = [[[MainController alloc] init] autorelease];
    UINavigationController *navApiVC = [[[UINavigationController alloc] initWithRootViewController:apiVC] autorelease];
    
    //左视图
    LeftSideViewController *leftVC = [[[LeftSideViewController alloc] init] autorelease];
    RightSideViewController * rightVC = [[[RightSideViewController alloc] init] autorelease];
    
//    UINavigationController * naLeft =[[[UINavigationController alloc] initWithRootViewController:leftVC] autorelease];
//    UINavigationController * naRight = [[[UINavigationController alloc] initWithRootViewController:rightVC] autorelease];
    
    IIViewDeckController *vc = [[[IIViewDeckController alloc] initWithCenterViewController:navApiVC leftViewController:leftVC rightViewController:rightVC] autorelease];
    vc.leftSize = self.window.width - (320 - 100.0);
    vc.rightSize = self.window.width - (320 - 100.0);
    self.viewController = vc;
    
    // Override point for customization after application launch.
    
    UINavigationController * naVC = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
    naVC.navigationBarHidden = YES;
    naVC.navigationBar.hidden = YES;
    naVC.delegate = navigation;
    
    self.window.rootViewController = naVC;
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    

//    [[AWVersionAgent sharedAgent] upgradeAppWithNotification:notification];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(newStatusBarOrientation))
    {
        self.viewController.leftSize = self.window.height - (320 - 100.0);
    }
    else
    {
        self.viewController.leftSize = self.window.width - (320 - 100.0);
    }
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)userInfoUpdateHandler:(NSNotification *)notif
{
    NSMutableArray *authList = [NSMutableArray arrayWithContentsOfFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()]];
    if (authList == nil)
    {
        authList = [NSMutableArray array];
    }
    
    NSString *platName = nil;
    NSInteger plat = [[[notif userInfo] objectForKey:SSK_PLAT] integerValue];
    switch (plat)
    {
        case ShareTypeSinaWeibo:
            platName = @"新浪微博";
            break;
        case ShareType163Weibo:
            platName = @"网易微博";
            break;
        case ShareTypeDouBan:
            platName = @"豆瓣";
            break;
        case ShareTypeFacebook:
            platName = @"Facebook";
            break;
        case ShareTypeKaixin:
            platName = @"开心网";
            break;
        case ShareTypeQQSpace:
            platName = @"QQ空间";
            break;
        case ShareTypeRenren:
            platName = @"人人网";
            break;
        case ShareTypeSohuWeibo:
            platName = @"搜狐微博";
            break;
        case ShareTypeTencentWeibo:
            platName = @"腾讯微博";
            break;
        case ShareTypeTwitter:
            platName = @"Twitter";
            break;
        case ShareTypeInstapaper:
            platName = @"Instapaper";
            break;
        case ShareTypeYouDaoNote:
            platName = @"有道云笔记";
            break;
        default:
            platName = @"未知";
    }
    id<ISSUserInfo> userInfo = [[notif userInfo] objectForKey:SSK_USER_INFO];
    
    BOOL hasExists = NO;
    for (int i = 0; i < [authList count]; i++)
    {
        NSMutableDictionary *item = [authList objectAtIndex:i];
        ShareType type = [[item objectForKey:@"type"] integerValue];
        if (type == plat)
        {
            [item setObject:[userInfo nickname] forKey:@"username"];
            hasExists = YES;
            break;
        }
    }
    
    if (!hasExists)
    {
        NSDictionary *newItem = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 platName,
                                 @"title",
                                 [NSNumber numberWithInteger:plat],
                                 @"type",
                                 [userInfo nickname],
                                 @"username",
                                 nil];
        [authList addObject:newItem];
    }
    
    [authList writeToFile:[NSString stringWithFormat:@"%@/authListCache.plist",NSTemporaryDirectory()] atomically:YES];
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return self.interfaceOrientationMask;
}

#pragma mark - WXApiDelegate

-(void) onReq:(BaseReq*)req
{
    
}

-(void) onResp:(BaseResp*)resp
{
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = (NSDictionary *)[user valueForKey:LoginUserDic];
    
    LoginController * login = [LoginController sharedLoginController];
    login.loginName = [dic valueForKey:@"userName"];
    login.loginTel = [dic valueForKey:@"userTel"];
    login.loginImgPath = [dic valueForKey:@"userImgPath"];
    login.loginCheck = [dic valueForKey:@"userCheck"];
    NSLog(@" %@ %@ %@",login.loginName,login.loginTel,login.loginCheck);
        
    BOOL isPatternSet = (login.loginCheck) ? YES: NO;
	if(self.window.rootViewController.presentingViewController == nil && isPatternSet)
    {
		WeakUpViewController *lockVc = [[WeakUpViewController alloc]init];
		lockVc.infoLabelStatus = InfoStatusNormal;
		[self.window.rootViewController presentViewController:lockVc animated:NO completion:^{
			//
		}];
	}

    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
