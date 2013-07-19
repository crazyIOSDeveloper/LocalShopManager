//
//  WeakUpViewController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "WeakUpViewController.h"
#import "LSMToolen.h"
#import "NormalCircle.h"
#import "LoginController.h"

@interface WeakUpViewController ()<LockScreenDelegate>

@property (nonatomic) NSInteger wrongGuessCount;
@end


@implementation WeakUpViewController
@synthesize infoLabelStatus;
@synthesize wrongGuessCount;
@synthesize infoLabel;
@synthesize resetCheckPWD;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        resetCheckPWD = NO;
    }
    return self;
}
-(void)dealloc
{
    [nameLbl release];
    [imgView release];
    
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    LoginController * login = [LoginController sharedLoginController];
    nameLbl.text = login.loginName;
    
    NSString * path = login.loginImgPath;
    UIImage * image = [LSMToolen imageFromSavePath:path];
    imgView.image =image;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    nameLbl.text = @"张三";
    [self.view addSubview:nameLbl];
    nameLbl.textAlignment= UITextAlignmentCenter;
    nameLbl.backgroundColor = [UIColor clearColor];
    nameLbl.center = CGPointMake(320/2.0, 30/2.0+20);
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    imgView.image = [UIImage imageNamed:@"2.jpeg"];
    [self.view addSubview:imgView];
    imgView.center = CGPointMake(320/2.0, nameLbl.center.y+50);
    
    self.infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 20)];
	self.infoLabel.backgroundColor = [UIColor clearColor];
	self.infoLabel.font = [UIFont systemFontOfSize:16];
	self.infoLabel.textColor = [UIColor whiteColor];
	self.infoLabel.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:self.infoLabel];
    self.infoLabel.center = CGPointMake(320/2.0, imgView.center.y+50);
    
    
    self.lockScreenView = [[SPLockScreen alloc]initWithFrame:CGRectMake(0, 0, 320,320)];
    
    self.lockScreenView.center = CGPointMake(320/2.0, self.infoLabel.center.y+200);
	self.lockScreenView.delegate = self;
	self.lockScreenView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:self.lockScreenView];
	
    changeCheck = [UIButton buttonWithType:UIButtonTypeCustom];
    changeCheck.frame = CGRectMake(0, 0, 100, 50);
    [changeCheck setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.view addSubview:changeCheck];
    changeCheck.center = CGPointMake(320/2.0, self.lockScreenView.center.y+100);
	[changeCheck setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeCheck addTarget:self action:@selector(forgetWeakUpCheckPWD:) forControlEvents:UIControlEventTouchUpInside];
    
	[self updateOutlook];
}
-(void)forgetWeakUpCheckPWD:(id)sender
{
    [LSMToolen noticeWithText:@"尚未完成，请使用其他账号登陆"];
}


- (void)updateOutlook
{
	switch (self.infoLabelStatus) {
		case InfoStatusFirstTimeSetting:
			self.infoLabel.text = @"请设置解锁密码";
			break;
		case InfoStatusConfirmSetting:
			self.infoLabel.text = @"请确认解锁密码";
			break;
		case InfoStatusFailedConfirm:
			self.infoLabel.text = @"解锁密码设定失败,请重新设定";
			break;
		case InfoStatusNormal:
			self.infoLabel.text = @"请输入解锁密码";
			break;
        case InfoStatusReset:
            self.infoLabel.text = @"请先确认解锁密码";
            break;
		case InfoStatusFailedMatch:
			self.infoLabel.text = [NSString stringWithFormat:@"密码错误s # %d, 请再次重试",self.wrongGuessCount];
			break;
		case InfoStatusSuccessMatch:
			self.infoLabel.text = @"Welcome !";
			break;
			
		default:
			break;
	}
	
}


#pragma -LockScreenDelegate

- (void)lockScreen:(SPLockScreen *)lockScreen didEndWithPattern:(NSNumber *)patternNumber
{
	NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
	NSLog(@"self status: %d",self.infoLabelStatus);
    LoginController * login = [LoginController  sharedLoginController];
    
	switch (self.infoLabelStatus) {
		case InfoStatusFirstTimeSetting:
			[stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
			self.infoLabelStatus = InfoStatusConfirmSetting;
			[self updateOutlook];
			break;
		case InfoStatusFailedConfirm:
			[stdDefault setValue:patternNumber forKey:kCurrentPatternTemp];
			self.infoLabelStatus = InfoStatusConfirmSetting;
			[self updateOutlook];
			break;
		case InfoStatusConfirmSetting:
			if([patternNumber isEqualToNumber:[stdDefault valueForKey:kCurrentPatternTemp]]) {
                
                login.loginCheck = [patternNumber stringValue];
                
                //密码设定结束，此时需要保存状态，并更新数据库
                NSNotification * notice = [NSNotification notificationWithName:LoginUserStateChangeNotifice object:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notice];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [self updateNowLoginUserCheckNum:nil];
                });
				[self dismissViewControllerAnimated:YES completion:nil];
			}
			else {
				self.infoLabelStatus = InfoStatusFailedConfirm;
				[self updateOutlook];
			}
			break;
		case  InfoStatusNormal:
        {
            
			if([[patternNumber stringValue] isEqualToString:login.loginCheck])
            {
                 [self dismissViewControllerAnimated:YES completion:nil];   
            }
			else {
				self.infoLabelStatus = InfoStatusFailedMatch;
				self.wrongGuessCount ++;
				[self updateOutlook];
			}
        }
			break;
        case InfoStatusReset:
        {
            resetCheckPWD = YES;
            if([[patternNumber stringValue] isEqualToString:login.loginCheck])
            {
                login.loginCheck = nil;
                [self updateNowLoginUserCheckNum:nil];
                
                self.infoLabelStatus = InfoStatusFirstTimeSetting;
				[self updateOutlook];
                
            }else
            {
                self.infoLabelStatus = InfoStatusFailedMatch;
				[self updateOutlook];
            }   
        }
            break;
		case InfoStatusFailedMatch:
			if([[patternNumber stringValue] isEqualToString:login.loginCheck])
            {
                if (resetCheckPWD)
                {
                    self.infoLabelStatus = InfoStatusFirstTimeSetting;
                    [self updateOutlook];
                    return;
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }
			else {
				self.wrongGuessCount ++;
				self.infoLabelStatus = InfoStatusFailedMatch;
				[self updateOutlook];
			}
			break;
		case InfoStatusSuccessMatch:
			[self dismissViewControllerAnimated:YES completion:nil];
			break;
			
		default:
			break;
	}
}

-(void)updateNowLoginUserCheckNum:(id)sender
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSDictionary * oldDic = [user valueForKey:LoginUserDic];
    
    LoginController * login = [LoginController  sharedLoginController];
    if (!oldDic)
    {
        oldDic =[login saveNowLoginUserDataToDefault];
    }
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:oldDic];
    if (login.loginCheck)
    {
        [dic setValue:login.loginCheck forKey:@"userCheck"];
    }else
    {
        [dic removeObjectForKey:@"userCheck"];
    }
    
    user = [NSUserDefaults standardUserDefaults];
    [user setValue:dic forKey:LoginUserDic];
    
    NSString *where = [NSString stringWithFormat:@"user_id='%@'", login.loginTel];
    LocalDBDataManager * manager = [LocalDBDataManager defaultManager];
    NSArray * array = [manager selectObjects:[PurchaserDataObject class] where:where];
    PurchaserDataObject * obj = [array lastObject];
    obj.checkNum = login.loginCheck;
    
    [manager updateObject:obj where:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
