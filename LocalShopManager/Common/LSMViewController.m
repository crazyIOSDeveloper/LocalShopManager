//
//  LSMViewController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-5.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "LSMViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface LSMViewController ()

@end

@implementation LSMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIButton * leftBtn = [self normalBtnForNavigationBarLeft];
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
       
        
        if ([UIDevice currentDevice].isPad)
        {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.shadowColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:22];
            self.navigationItem.titleView = label;
            [label release];
        }

    }
    return self;
}

-(UIButton *)normalBtnForNavigationBarLeft
{
    UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"Common/NavigationButtonBG.png" bundleName:BUNDLE_NAME]
                       forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
    
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    return leftBtn;
}
-(UIButton *)normalBtnForNavigationBarRight
{
    return nil;
}

-(CGRect)showViewBoundsWithTabBarShow:(BOOL)showTab
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect.origin = CGPointZero;
    rect.size.height -= 44;
    rect.size.height -= 20;
    if (showTab)
    {
        rect.size.height -= 49;
    }
    
    
    return rect;
}
-(void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

//当前结构下，中间视图推出普通视图
-(void)pushInMainWithNormalNextController:(UIViewController *)controller
{
    [self.navigationController pushViewController:controller animated:YES];
}
//当前结构下，两边视图退出普通视图
-(void)pushInSlideWithNormalNextController:(UIViewController *)controller
{
    [self.viewDeckController.navigationController pushViewController:controller animated:YES];
}

//推出下个视图，
-(void)pushNextController:(UIViewController *)controller withMainScrollEnabled:(BOOL)enable
{
    UINavigationController * naController = self.navigationController;
    if (!enable)
    {
        naController =self.viewDeckController.navigationController;
    }
    
    [naController pushViewController:controller animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self layoutView:self.interfaceOrientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(BOOL)shouldAutorotate
{
    //iOS6下旋屏方法
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    //iOS6下旋屏方法
    return SSInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutView:toInterfaceOrientation];
}
#pragma mark layoutLandscapeAndPortrait
- (void)layoutPortrait
{
    UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    btn.frame = CGRectMake(btn.left, btn.top, 55.0, 32.0);
    [btn setBackgroundImage:[UIImage imageNamed:@"Common/NavigationButtonBG.png"
                                     bundleName:BUNDLE_NAME]
                   forState:UIControlStateNormal];
    
    if ([UIDevice currentDevice].isPad)
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPadNavigationBarBG.png"]];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneNavigationBarBG.png"]];
    }
}

- (void)layoutLandscape
{
    if (![UIDevice currentDevice].isPad)
    {
        //iPhone
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        btn.frame = CGRectMake(btn.left, btn.top, 48.0, 24.0);
        [btn setBackgroundImage:[UIImage imageNamed:@"Common_Landscape/NavigationButtonBG.png"
                                         bundleName:BUNDLE_NAME]
                       forState:UIControlStateNormal];
        
        if ([[UIDevice currentDevice] isPhone5])
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneLandscapeNavigationBarBG-568h.png"]];
        }
        else
        {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneLandscapeNavigationBarBG.png"]];
        }
    }
    else
    {
        UIButton *btn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
        btn.frame = CGRectMake(btn.left, btn.top, 55.0, 32.0);
        [btn setBackgroundImage:[UIImage imageNamed:@"Common/NavigationButtonBG.png"
                                         bundleName:BUNDLE_NAME]
                       forState:UIControlStateNormal];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPadLandscapeNavigationBarBG.png"]];
    }
}

- (void)layoutView:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        [self layoutLandscape];
    }
    else
    {
        [self layoutPortrait];
    }
}

#pragma mark -----------------
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
