//
//  WelcomeController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-6-30.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "WelcomeController.h"

@interface WelcomeController ()

@end

@implementation WelcomeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)appendTapGesture:(id)sender
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideWelcomeView:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRGB:0xe1e0de];
    [self appendTapGesture:nil];
    
    UIView * overView = self.view;
    CGRect rect = overView.frame;
    
    UILabel * showLbl =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [overView addSubview:showLbl];
    showLbl.backgroundColor = [UIColor clearColor];
    
    showLbl.center = CGPointMake(rect.size.width/2.0, rect.size.height/2.0);
    [showLbl release];
    
    showLbl.text = @"加油！好运！";

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0
    showLbl.textAlignment = NSTextAlignmentCenter;
//    NSLog(@"__IPHONE_OS_VERSION_MAX_ALLOWED %d",__IPHONE_OS_VERSION_MAX_ALLOWED);
#else
    showLbl.textAlignment = UITextAlignmentCenter;
#endif
    
    
}

-(void)hideWelcomeView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
    //发送welcome回收的消息通知
    NSNotification * notice = [NSNotification notificationWithName:WelComeViewHideDoneNotifice object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
