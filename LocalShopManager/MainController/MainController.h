//
//  MainController.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-6-30.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTabView.h"
#import "LSMViewController.h"

#import "ZBarSDK.h"
//主控制器，控制应用的根控制器
@interface MainController : LSMViewController<JMTabViewDelegate,ZBarReaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    @private
    UITableView * _tableView;
    NSMutableArray * _showArr;
    
    
    
    UIView * lastContentView;
}



@end
