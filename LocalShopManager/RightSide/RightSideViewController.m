//
//  RightSideViewController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-5.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "RightSideViewController.h"
#import "AGLeftSideTableCell.h"
#import "MainController.h"
#import "RightHeadCell.h"
#import "RightNormalCell.h"
#import "LoginController.h"
#import "LSMToolen.h"
#import "WeakUpViewController.h"

#define Right_TABLE_CELL @"tableCell_TABLE_CELL"
#define Right_Head_CELL @"Right_Head_CELL"

@interface RightSideViewController ()

@end

@implementation RightSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRGB:0xe1e0de];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG.png"]];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgImageView.frame = CGRectMake(0.0, 0.0, self.view.width, self.view.height);
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.width, self.view.height)
                                              style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 32;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeLoginState:)
                                                 name:LoginUserStateChangeNotifice
                                               object:nil];
    
}

-(void)changeLoginState:(id)sender
{
    [_tableView reloadData];
    [self.viewDeckController closeRightViewAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    int index = indexPath.row;
    if (index==0)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RightHeadCell" owner:nil options:nil] lastObject];
    }else
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RightNormalCell" owner:nil options:nil] lastObject];
    }
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    int section = indexPath.section;
    
    UITableViewCell *cell = nil;

    if (index==0&&section==0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:Right_Head_CELL];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RightHeadCell" owner:nil options:nil] lastObject];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
            //        cell.textLabel.textColor = [UIColor colorWithRGB:0xc3c3c2];
            
            UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
            lineView.frame = CGRectMake(0.0, cell.contentView.height - lineView.height , cell.contentView.width, lineView.height);
            lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [cell addSubview:lineView];
            [lineView release];
        }
        
        
        LoginController * login = [LoginController sharedLoginController];
        RightHeadCell * head = (RightHeadCell *)cell;
        if (!login.loginName)
        {
            [head resetCellWith:nil andTel:@"您尚未登陆，点击登陆" andName:@"登陆账号"];
        }else
        {
            [head resetCellWith:login.loginImgPath andTel:login.loginTel andName:login.loginName];

        }
    }else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:Right_TABLE_CELL];
        if (cell==nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"RightNormalCell" owner:nil options:nil] lastObject];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
            //        cell.textLabel.textColor = [UIColor colorWithRGB:0xc3c3c2];
            
            UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
            lineView.frame = CGRectMake(0.0, cell.contentView.height - lineView.height , cell.contentView.width, lineView.height);
            lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [cell addSubview:lineView];
            [lineView release];

        }
        
        NSString * showText = nil;
        switch (index)
        {
            case 1:
            {
                LoginController * login=[LoginController sharedLoginController];
                NSString * checkNum = [login loginCheck];
                
                if (!checkNum)
                {
                    showText = [NSString stringWithFormat:@"设置解锁密码"];                    
                }else
                {
                    showText = [NSString stringWithFormat:@"修改解锁密码"];
                }

            }
                break;
            case 2:
            {
                showText = [NSString stringWithFormat:@"版本检查更新"];
            }
                break;
            case 3:
            {
                showText = [NSString stringWithFormat:@"关于我们"];
            }
                break;
                
            default:
                break;
        }
        RightNormalCell * normal=(RightNormalCell *)cell;
        normal.showContentLbl.text = showText;
        
    }


    
    
       
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int index = indexPath.row;
    NSLog(@"deselectRowAtIndexPath %d",index);
    switch (index)
    {
        case 0:
        {
            NSString * userName = [[LoginController sharedLoginController] loginName];
            if (userName)
            {
                
                NSString * showMessage = [NSString stringWithFormat:@"您确定要退出 账号 %@ 的登陆",userName];
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                 message:showMessage
                                                                delegate:self
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:@"取消", nil];
                [alert show];
                [alert release];
                
                return;
            }
            
            UIViewController * login = [FactoryController loginInControllerWithSender:nil];
            [self pushInMainWithNormalNextController:login];

        }
            break;
        case 1:
        {
            NSString * userName = [[LoginController sharedLoginController] loginName];
            if (!userName)
            {
                
                [LSMToolen noticeWithText:@"请先登陆"];
                return;
            }
            
            NSString * userCheck = [[LoginController sharedLoginController] loginCheck];
            if (!userCheck)
            {
                WeakUpViewController *lockVc = [[WeakUpViewController alloc]init];
                lockVc.infoLabelStatus = InfoStatusFirstTimeSetting;
                [self pushInMainWithNormalNextController:lockVc];
                
                return;
            }
            
            WeakUpViewController *lockVc = [[WeakUpViewController alloc]init];
            lockVc.infoLabelStatus = InfoStatusReset;
            [self pushInMainWithNormalNextController:lockVc];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        LoginController * login =[LoginController sharedLoginController];
        [login quitUserLogin:nil];
        
        [self.viewDeckController closeRightViewAnimated:YES];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
