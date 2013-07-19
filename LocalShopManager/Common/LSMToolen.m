//
//  LSMToolen.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-8.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "LSMToolen.h"
#import "BDKNotifyHUD.h"

@implementation LSMToolen

static BDKNotifyHUD * _BDKNotifyHUD = nil;
+(void)noticeWithText:(NSString *)text
{
    UIView * newView = [[UIApplication sharedApplication] keyWindow];
    if (!_BDKNotifyHUD)
    {
        _BDKNotifyHUD = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"Checkmark.png"] text:text];
        _BDKNotifyHUD.center=CGPointMake(newView.center.x, newView.center.y+10 );
    }
    _BDKNotifyHUD.text = text;
    if (_BDKNotifyHUD.isAnimating) return;
    
    [newView addSubview:_BDKNotifyHUD];
    [_BDKNotifyHUD presentWithDuration:1.0f speed:0.5f inView:newView completion:^{
        [_BDKNotifyHUD removeFromSuperview];
    }];
    
    
}
+(NSString *)imgPathForApp:(id)sender
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * headImgs = @"HeadImgs";
    NSString * appendImgs = [cachePath stringByAppendingPathComponent:headImgs];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^
                   {
                       NSFileManager *fileManager = [NSFileManager defaultManager];
                       if (![fileManager fileExistsAtPath:appendImgs])
                       {
                           [fileManager createDirectoryAtPath:appendImgs withIntermediateDirectories:YES attributes:nil error:NULL];
                           NSLog(@"create headImgs");
                       }

                   });
    return appendImgs;
    
}
+(UIImage *)imageFromSavePath:(NSString *)pathStr
{
    NSArray * array = [pathStr componentsSeparatedByString:@"/"];
    UIImage * imge = nil;
    if ([array count]==1)
    {
        imge = [UIImage imageNamed:pathStr];
    }else
    {
        imge = [UIImage imageWithContentsOfFile:pathStr];
    }
    return imge;
}

//打印子视图
+(void)showSubViewsOfView:(UIView *)aView
{
    int number = 0;
    NSLog(@"子视图遍历 %@\n",aView);
    [LSMToolen printView:aView andIndex:number];
    NSLog(@"遍历结束 \n");
}
+(void)printView:(UIView *)aView andIndex:(int)index
{
    NSLog(@"[%d] %@",index,aView);
    for (UIView * eveView in [aView subviews])
    {
        [LSMToolen printView:eveView andIndex:index+1];
    }
    
}



@end
