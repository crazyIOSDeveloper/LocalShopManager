//
//  GTLoadingViewController.m
//  GTTabBarDemo
//
//  Created by GTL on 13-6-6.
//  Copyright (c) 2013年 phisung. All rights reserved.
//

#import "GTLoadingViewController.h"

@interface GTLoadingViewController ()

@end

@implementation GTLoadingViewController

@synthesize bgImageView1;
@synthesize bgImageView2;

#pragma mark - View lifecycle methods
- (void)viewDidLoad
{
    
//    bgImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 160, 460+88)];
//    bgImageView1.backgroundColor = [UIColor clearColor];
//    bgImageView1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading_01" ofType:@"png"]];
//    [self.view addSubview:bgImageView1];
//    bgImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(160, -20, 160, 460+88)];
//    bgImageView2.backgroundColor = [UIColor clearColor];
//    bgImageView2.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loading_02" ofType:@"png"]];
//    [self.view addSubview:bgImageView2];

    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 320, 460+20)];
    img.backgroundColor = [UIColor clearColor];
    img.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default" ofType:@"png"]];
    [self.view addSubview:img];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 400, 20, 20)];
    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    _activityIndicatorView.hidesWhenStopped = YES;
    [_activityIndicatorView startAnimating];
    [self.view addSubview:_activityIndicatorView];
    
    [self performSelector:@selector(loadingDone) withObject:nil afterDelay:0.6];    // 假设加载3秒中
    
    [super viewDidLoad];

}

- (void)loadingDone
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    //发送welcome回收的消息通知
    
    [_activityIndicatorView stopAnimating];
//    [self loadingViewAnimation];
    [self loadingViewAnimationDone];
    
}
- (void)loadingViewAnimation {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(loadingViewAnimationDone)];
    [UIView setAnimationDuration:2];
    self.bgImageView1.frame = CGRectMake(self.bgImageView1.frame.origin.x-160, self.bgImageView1.frame.origin.y, self.bgImageView1.frame.size.width, self.bgImageView1.frame.size.height);
    self.bgImageView2.frame = CGRectMake(self.bgImageView2.frame.origin.x+160, self.bgImageView2.frame.origin.y, self.bgImageView2.frame.size.width, self.bgImageView2.frame.size.height);
    [UIView commitAnimations];
}
- (void)loadingViewAnimationDone
{
    [self dismissModalViewControllerAnimated:YES];
    
    //发送welcome回收的消息通知
    NSNotification * notice = [NSNotification notificationWithName:WelComeViewHideDoneNotifice object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}




@end
