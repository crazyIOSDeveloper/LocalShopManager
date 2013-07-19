//
//  LSMViewController.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-5.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>
//此类作为UIVIiewController的子类，其他controller的父类使用
//作用，方便相互之间引用，公用横竖屏代码

#import "IIViewDeckController.h"

@interface LSMViewController : UIViewController

-(UIButton *)normalBtnForNavigationBarLeft;
-(UIButton *)normalBtnForNavigationBarRight;

-(CGRect)showViewBoundsWithTabBarShow:(BOOL)hidden;

//当前结构下，中间视图推出普通视图
-(void)pushInMainWithNormalNextController:(UIViewController *)controller;
//当前结构下，两边视图退出普通视图
-(void)pushInSlideWithNormalNextController:(UIViewController *)controller;

//推出下个视图，
-(void)pushNextController:(UIViewController *)controller withMainScrollEnabled:(BOOL)enable;


@end
