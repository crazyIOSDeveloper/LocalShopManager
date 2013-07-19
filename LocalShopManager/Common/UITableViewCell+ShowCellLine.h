//
//  UITableViewCell+ShowCellLine.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-17.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ShowCellLine)

//添加底线
-(void)addNormalBottomLineToCell;

//移除底线
-(void)removeNormalBottomLineFromCell;

//添加头线
-(void)addNormalHeaderLineFromCell;

//移除头线
-(void)removeNormalHeaderLineFromCell;

@end
