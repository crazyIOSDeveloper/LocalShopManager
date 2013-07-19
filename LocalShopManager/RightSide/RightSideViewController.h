//
//  RightSideViewController.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-5.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSMViewController.h"
@interface RightSideViewController : LSMViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
@private
    UITableView *_tableView;
}

@end
