//
//  WeakUpViewController.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLockScreen.h"

typedef enum {
	InfoStatusFirstTimeSetting = 0,
	InfoStatusConfirmSetting,
	InfoStatusFailedConfirm,
	InfoStatusNormal,
    InfoStatusReset,
	InfoStatusFailedMatch,
	InfoStatusSuccessMatch
}	InfoStatus;
@interface WeakUpViewController : UIViewController
{
    UILabel * nameLbl;
    UIImageView * imgView;
    
    UIButton * changeCheck;
}

@property (nonatomic,assign) BOOL resetCheckPWD;

@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet SPLockScreen *lockScreenView;
@property (nonatomic) InfoStatus infoLabelStatus;


@end
