//
//  Constant.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-6-30.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <Foundation/Foundation.h>

//进行常见的宏定义

#define WelComeViewHideDoneNotifice @"WelComeViewHideDoneNotifice"//欢迎界面结束

#define LoginUserStateChangeNotifice @"LoginUserStateChangeNotifice"//状态改变

#define LoginUserDic @"LoginUserDic"

#define kCurrentPattern	@"KeyForCurrentPatternToUnlock"
#define kCurrentPatternTemp  @"KeyForCurrentPatternToUnlockTemp"

#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#define EMPTY_STRING        @""

#define STR(key)            NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#import <AGCommon/AGCommon.h>
#import <AGCommon/UIDevice+Common.h>
#import <AGCommon/UIView+Common.h>
#import <AGCommon/UIColor+Common.h>
#import <AGCommon/UINavigationBar+Common.h>
#import <AGCommon/UIImage+Common.h>
#import <AGCommon/NSMutableURLRequest+Common.h>
#import <AGCommon/NSDate+Common.h>

#import "LSDataObject.h"
#import "SDImageView+SDWebCache.h"
#import "LSMToolen.h"
#import "FactoryController.h"
#import "FactoryFMDBManager.h"
#import "UITableViewCell+ShowCellLine.h"
#import "JSONKit.h"

