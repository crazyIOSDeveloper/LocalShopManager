//
//  QQViewController.m
//  QQLogin
//
//  Created by Reese on 13-6-17.
//  Copyright (c) 2013年 Reese. All rights reserved.
//

#import "QQViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DBSignupViewController.h"
#import "CheckPWDController.h"
#import "LoginController.h"
#import "LSMToolen.h"
#define ANIMATION_DURATION 0.3f

@interface QQViewController ()

@end

@implementation QQViewController
-(id)init
{
    self = [super init];
    if (self)
    {
        _currentAccounts = [[NSMutableArray alloc] init];
        self.title = @"登陆";
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSDictionary *account1=[NSDictionary dictionaryWithObjectsAndKeys:@"109327402",@"userNumber",@"123456",@"passWord",@"1.jpeg",@"userHead", nil];
//    NSDictionary *account2=[NSDictionary dictionaryWithObjectsAndKeys:@"1298312",@"userNumber",@"29843223",@"passWord",@"2.jpeg",@"userHead", nil];
//    
//    _currentAccounts=[[NSMutableArray arrayWithObjects:account1,account2, nil]retain];
//    [_currentAccounts removeAllObjects];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self readLoginHistory:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadAccountBox];
        });
    });
}

-(void)readLoginHistory:(id)sender
{
    NSArray * array = [FactoryFMDBManager listArrayFromLocalDBWith:[PurchaserDataObject class]];

    [_currentAccounts removeAllObjects];
    for (PurchaserDataObject * obj in array )
    {

        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        if (obj.personIdStr_)
        {
            [dic setValue:obj.personIdStr_ forKey:@"userNumber"];
        }
        [dic setValue:@"" forKey:@"passWord"];
        if (obj.loginPWD)
        {
            [dic setValue:obj.loginPWD forKey:@"passWord"];
        }
        [dic setValue:@"2.jpeg" forKey:@"userHead"];
        if (obj.relativeDSC_)
        {
            [dic setValue:obj.relativeDSC_ forKey:@"userHead"];
        }
        [_currentAccounts addObject:dic];
    }
    NSLog(@"_currentAccounts %@",_currentAccounts);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_dropButton release];
    [_moveDownGroup release];
    [_account_box release];
    [_userNumber release];
    [_userPassword release];
    [_userLargeHead release];
    [_numberLabel release];
    [_passwordLabel release];
    [super dealloc];
}
- (IBAction)dropDown:(id)sender {
    
    if ([sender isSelected]) {
        
        [self hideAccountBox];
        
    }else
    {
        
        [self showAccountBox];
        
    }
    
}

-(void)showAccountBox
{
    [_dropButton setSelected:YES];
    CABasicAnimation *move=[CABasicAnimation animationWithKeyPath:@"position"];
    [move setFromValue:[NSValue valueWithCGPoint:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y)]];
    [move setToValue:[NSValue valueWithCGPoint:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y+_account_box.frame.size.height)]];
    [move setDuration:ANIMATION_DURATION];
    [_moveDownGroup.layer addAnimation:move forKey:nil];
    
    
    [_account_box setHidden:NO];
    
    //模糊处理
    [_userLargeHead setAlpha:0.5f];
    [_numberLabel setAlpha:0.5f];
    [_passwordLabel setAlpha:0.5f];
    [_userNumber setAlpha:0.5f];
    [_userPassword setAlpha:0.5f];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform"];
    [scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.2, 1.0)]];
    [scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    CABasicAnimation *center=[CABasicAnimation animationWithKeyPath:@"position"];
    [center setFromValue:[NSValue valueWithCGPoint:CGPointMake(_account_box.center.x, _account_box.center.y-_account_box.bounds.size.height/2)]];
    [center setToValue:[NSValue valueWithCGPoint:CGPointMake(_account_box.center.x, _account_box.center.y)]];
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:scale,center, nil]];
    [group setDuration:ANIMATION_DURATION];
    [_account_box.layer addAnimation:group forKey:nil];
    
    
    
    [_moveDownGroup setCenter:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y+_account_box.frame.size.height)];
    
}
-(void)hideAccountBox
{
    [_dropButton setSelected:NO];
    CABasicAnimation *move=[CABasicAnimation animationWithKeyPath:@"position"];
    [move setFromValue:[NSValue valueWithCGPoint:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y)]];
    [move setToValue:[NSValue valueWithCGPoint:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y-_account_box.frame.size.height)]];
    [move setDuration:ANIMATION_DURATION];
    [_moveDownGroup.layer addAnimation:move forKey:nil];
    
    [_moveDownGroup setCenter:CGPointMake(_moveDownGroup.center.x, _moveDownGroup.center.y-_account_box.frame.size.height)];
    [_userLargeHead setAlpha:1.0f];
    [_numberLabel setAlpha:1.0f];
    [_passwordLabel setAlpha:1.0f];
    [_userNumber setAlpha:1.0f];
    [_userPassword setAlpha:1.0f];
    
    CABasicAnimation *scale=[CABasicAnimation animationWithKeyPath:@"transform"];
    [scale setFromValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [scale setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.2, 1.0)]];
    
    CABasicAnimation *center=[CABasicAnimation animationWithKeyPath:@"position"];
    [center setFromValue:[NSValue valueWithCGPoint:CGPointMake(_account_box.center.x, _account_box.center.y)]];
    [center setToValue:[NSValue valueWithCGPoint:CGPointMake(_account_box.center.x, _account_box.center.y-_account_box.bounds.size.height/2)]];
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.0];
    
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:scale,center,opacityAnim, nil]];
    [group setDuration:ANIMATION_DURATION];
    
    [_account_box.layer addAnimation:group forKey:nil];
    
    [self performSelector:@selector(hideAccountBoxDone:) withObject:nil afterDelay:ANIMATION_DURATION-0.1];

    
}


-(void)hideAccountBoxDone:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_account_box setHidden:YES];
        _account_box.alpha = 1.0;
    });

}

-(void)reloadAccountBox
{
    for (UIView* view in _account_box.subviews) {
        if (view.tag!=20000) {
            [view removeFromSuperview];
        } 
    }
    int count=_currentAccounts.count;
    //图片之间的间距
    CGFloat insets;
    
    
    //图片的宽度与背景的宽度
    CGFloat imageWidth=49,bgWidth=288,bgHeight=80;
    
    //根据账号数量对3的商来计算整个view高度的调整
    CGFloat newHeight;
    newHeight=((count-1)/3)*80+80;
    if (newHeight!=bgHeight) {
        [_account_box setFrame:CGRectMake(_account_box.frame.origin.x, _account_box.frame.origin.y, _account_box.frame.size.width, newHeight)];
    }
    
    CGFloat paddingTop=(bgHeight-imageWidth)/2;
    CGFloat paddingLeft=(320-bgWidth)/2;
    if (count >3) {
        insets=insets=(bgWidth-imageWidth*3)/4;
    }else{
    //根据图片数量对3取模计算间距
    switch (count%3) {
        case 0:
            insets=(bgWidth-imageWidth*3)/4;
            
            break;
        case 1:
            insets=(bgWidth-imageWidth)/2;
            break;
        case 2:
            insets=(bgWidth-imageWidth*2)/3;
            break;
        default:
            break;
    }
    }
    


    for (int i=0;i<_currentAccounts.count;i++)
    {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(paddingLeft+insets+(i%3)*(imageWidth+insets), paddingTop+80*(i/3), imageWidth, imageWidth)];
        [button setBackgroundImage:[UIImage imageNamed:@"login_dropdown_avatar_border"] forState:UIControlStateNormal];
        [button.imageView setImage:[UIImage imageNamed:@"login_avatar"]];
        button.tag=10000+i;
        [button addTarget:self action:@selector(chooseAccount:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45 , 45)];
        [headImage.layer setCornerRadius:3.0];
        [headImage setClipsToBounds:YES];
        [headImage setCenter:CGPointMake(button.center.x, button.center.y)];
        NSString * pathStr = [_currentAccounts[i] objectForKey:@"userHead"];
        UIImage * img = [LSMToolen imageFromSavePath:pathStr];
        headImage.image= img;
        [_account_box addSubview:headImage];
        [_account_box addSubview:button];
        
    }
}

- (void)chooseAccount:(UIButton*)button
{
    int accountIndex=button.tag-10000;
    [_userNumber setText:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"userNumber"] ];
    [_userPassword setText:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"passWord"]];
    NSString * pathStr = [_currentAccounts[accountIndex] objectForKey:@"userHead"];
    UIImage * img = [LSMToolen imageFromSavePath:pathStr];
    
    [_userLargeHead setImage:img];
//    [_userLargeHead setImage:[UIImage imageNamed:[[_currentAccounts objectAtIndex:accountIndex] objectForKey:@"userHead"]]];
    
    [self hideAccountBox];
}
- (IBAction)showAccountHistory:(id)sender
{
    [self dropDown:_dropButton];
}

- (IBAction)login:(id)sender {
//    NSDictionary *account=[NSDictionary dictionaryWithObjectsAndKeys:_userNumber.text,@"userNumber",_userPassword.text,@"passWord",@"3.jpeg",@"userHead", nil];
//    [_currentAccounts addObject:account];
    
    //检查
    NSString * notice = [self noticeForLoginCheck:nil];
    if (notice)
    {
        [LSMToolen noticeWithText:notice];
        return;
    }
    
        //密码校验
    BOOL checkPWD = [self checkLoginPWD:nil];
    if (!checkPWD)
    {
        [LSMToolen noticeWithText:@"账号或密码错误"];
        return;

    }
    [self loginSuccess:nil];
    
}
-(BOOL)checkLoginPWD:(id)sender
{
    NSString * telNum = self.userNumber.text;
    NSString * pwd = self.userPassword.text;
    PurchaserDataObject * obj = [FactoryFMDBManager purchaseForTelNum:telNum];
    if (pwd&&[obj.loginPWD isEqualToString:pwd])
    {
        LoginController * login = [LoginController sharedLoginController];
        login.loginTel = telNum;
        login.loginName = obj.name_;
        login.loginImgPath = obj.relativeDSC_;
        login.loginCheck = obj.checkNum;
        
        NSNotification * notice = [NSNotification notificationWithName:LoginUserStateChangeNotifice object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notice];
        
        return YES;
    }
    return NO;
}


-(NSString *)noticeForLoginCheck:(id)sender
{
    if (!self.userNumber.text)
    {
        return @"请输入手机号码";
    }
    if (!self.userPassword.text)
    {
        return @"请输入密码";
    }
    return nil;
}


-(void)loginSuccess:(id)sender
{
    [LSMToolen noticeWithText:@"登陆成功"];
    
    LoginController * login = [LoginController sharedLoginController];
    [login saveNowLoginUserDataToDefault];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)registerNewPurchase:(id)sender
{
    UIViewController * regist = [FactoryController registControllerWithSender:nil];
    [self.navigationController pushViewController:regist animated:YES];
    
    
}

- (IBAction)getPWDBack:(id)sender
{
    UIViewController * regist = [FactoryController checkPWDControllerWithSender:nil];
    [self.navigationController pushViewController:regist animated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_userNumber resignFirstResponder];
    [_userPassword resignFirstResponder];
}
@end
