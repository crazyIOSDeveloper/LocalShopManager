//
//  RightHeadCell.h
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightHeadCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *userNameLbl;
@property (retain, nonatomic) IBOutlet UILabel *userTelNumLbl;
@property (retain, nonatomic) IBOutlet UIImageView *userImgView;

-(void)resetCellWith:(NSString *)path andTel:(NSString *)tel andName:(NSString *)name;

@end
