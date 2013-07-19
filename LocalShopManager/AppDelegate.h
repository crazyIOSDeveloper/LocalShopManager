//
//  AppDelegate.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-6-30.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WBApi.h"
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDK/ShareSDK.h>
#import "HomeNavigationDelegate.h"
@class IIViewDeckController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    @private
       SSInterfaceOrientationMask _interfaceOrientationMask;
        HomeNavigationDelegate * navigation;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain) IIViewDeckController * viewController;

@property (nonatomic) SSInterfaceOrientationMask interfaceOrientationMask;


@end
