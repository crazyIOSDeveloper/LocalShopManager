//
//  UITableViewCell+ShowCellLine.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-17.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "UITableViewCell+ShowCellLine.h"
#define BOTTOM_LINE_TAG 1111
#define HEADER_LINE_TAG 1112


@implementation UITableViewCell (ShowCellLine)

-(UIImageView *)normalLineImageView
{
    UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
    lineView.frame = CGRectMake(0.0, self.frame.size.height - lineView.frame.size.height , self.frame.size.width, lineView.frame.size.height);
    lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    [self addSubview:lineView]
    
    return [lineView autorelease];
}



//添加底线
-(void)addNormalBottomLineToCell
{
    UIView * line = [self viewWithTag:BOTTOM_LINE_TAG];
    if (!line)
    {
        line = [self normalLineImageView];
        line.tag = BOTTOM_LINE_TAG;
    }
    line.frame = CGRectMake(0.0, self.frame.size.height - line.frame.size.height , line.frame.size.width, line.frame.size.height);
    [self addSubview:line];
}


//移除底线
-(void)removeNormalBottomLineFromCell
{
    UIView * line = [self viewWithTag:BOTTOM_LINE_TAG];
    [line removeFromSuperview];
}

//添加头线
-(void)addNormalHeaderLineFromCell
{
    UIView * line = [self viewWithTag:HEADER_LINE_TAG];
    if (!line)
    {
        line = [self normalLineImageView];
        line.tag = HEADER_LINE_TAG;
    }
    line.frame = CGRectMake(0.0, 0.0 , line.frame.size.width, line.frame.size.height);
    [self addSubview:line];
}

//移除头线
-(void)removeNormalHeaderLineFromCell
{
    UIView * line = [self viewWithTag:HEADER_LINE_TAG];
    [line removeFromSuperview];
}



@end
