//
//  HomeNavigationDelegate.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "HomeNavigationDelegate.h"
#import "MainController.h"
#import "IIViewDeckController.h"
@implementation HomeNavigationDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL backHome = NO;
    //之后根据首页的设计风格，决定此处是否放开,首页面，不使用navigationbar
    backHome = [viewController isKindOfClass:[MainController class]]||[viewController isKindOfClass:[IIViewDeckController class]];
    
    navigationController.navigationBar.hidden = backHome;
    navigationController.navigationBarHidden = backHome;
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}


@end
