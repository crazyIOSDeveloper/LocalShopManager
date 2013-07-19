//
//  RightHeadCell.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "RightHeadCell.h"

@implementation RightHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)resetCellWith:(NSString *)path andTel:(NSString *)tel andName:(NSString *)name
{
    NSArray * array = [path componentsSeparatedByString:@"/"];
    UIImage * img = nil;
    if ([array count]==1)
    {
        img= [UIImage imageNamed:path];
    }else
    {
        img = [UIImage imageWithContentsOfFile:path];
    }
    
    if (path)
    {
        self.userImgView.image = img;
    }
    
    
    self.userNameLbl.text = name;
    self.userTelNumLbl.text = tel;
    
    
}
- (void)dealloc {
    [_userImgView release];
    [_userNameLbl release];
    [_userTelNumLbl release];
    [super dealloc];
}
@end
