//
//  QQViewController.h
//  QQLogin
//
//  Created by Reese on 13-6-17.
//  Copyright (c) 2013年 Reese. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSMDetailViewController.h"
@interface QQViewController :LSMDetailViewController
{
    NSMutableArray *_currentAccounts;
}


@property (retain, nonatomic) IBOutlet UIButton *dropButton;
- (IBAction)dropDown:(id)sender;
@property (retain, nonatomic) IBOutlet UIView *moveDownGroup;
@property (retain, nonatomic) IBOutlet UIView *account_box;


@property (retain, nonatomic) IBOutlet UITextField *userNumber;
@property (retain, nonatomic) IBOutlet UILabel *numberLabel;
@property (retain, nonatomic) IBOutlet UITextField *userPassword;
@property (retain, nonatomic) IBOutlet UILabel *passwordLabel;

@property (retain, nonatomic) IBOutlet UIImageView *userLargeHead;
- (IBAction)showAccountHistory:(id)sender;

- (IBAction)login:(id)sender;
- (IBAction)registerNewPurchase:(id)sender;
- (IBAction)getPWDBack:(id)sender;

@end
