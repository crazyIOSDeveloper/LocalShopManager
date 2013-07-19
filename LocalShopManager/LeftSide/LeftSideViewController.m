//
//  LeftSideViewController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-5.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "LeftSideViewController.h"
#import "AGLeftSideTableCell.h"
#import "IIViewDeckController.h"
#import "MainController.h"
#import "LoginController.h"

#define TABLE_CELL @"tableCell"
@interface LeftSideViewController ()

@end

@implementation LeftSideViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG.png"]];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgImageView.frame = CGRectMake(0.0, 0.0, self.view.width, self.view.height);
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.width, self.view.height)
                                              style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 32;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    [_tableView release];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 6;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_CELL];
    if (cell == nil)
    {
        cell = [[[AGLeftSideTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_CELL] autorelease];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
        //        cell.textLabel.textColor = [UIColor colorWithRGB:0xc3c3c2];
        
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        lineView.frame = CGRectMake(0.0, cell.contentView.height - lineView.height , cell.contentView.width, lineView.height);
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell addSubview:lineView];
        [lineView release];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"包袋";
                    break;
                case 1:
                    cell.textLabel.text = @"腕表";
                    break;
                case 2:
                    cell.textLabel.text = @"服饰";
                    break;
                case 3:
                    cell.textLabel.text = @"首饰";
                    break;
                case 4:
                    cell.textLabel.text = @"美妆";
                    break;
                case 5:
                    cell.textLabel.text = @"豪车";
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"品牌馆";
                    break;
                case 1:
                    cell.textLabel.text = @"名品特惠";
                    break;
                case 2:
                    cell.textLabel.text = @"大牌0元租";
                    break;
                case 3:
                    cell.textLabel.text = @"访问官方网站";
                    break;
                case 4:
                {
                    NSBundle *bundle = [NSBundle mainBundle];
                    cell.textLabel.text = [NSString stringWithFormat:@"Demo版本 ver%@",[[bundle infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"男士";
                    break;
                case 1:
                    cell.textLabel.text = @"女士";
                    break;
                case 2:
                    cell.textLabel.text = @"大牌0元租";
                    break;
                case 3:
                    cell.textLabel.text = @"访问官方网站";
                    break;
                case 4:
                {
                    NSBundle *bundle = [NSBundle mainBundle];
                    cell.textLabel.text = [NSString stringWithFormat:@"Demo版本 ver%@",[[bundle infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
                    break;
                }
                default:
                    break;
            }
        }
        break;
        default:
            break;
    }
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int index = indexPath.section;
    int rowNum = indexPath.row;
    
//    self.view.userInteractionEnabled = NO;
    NSLog(@"deselectRowAtIndexPath %d %d",index,rowNum);
    
    [self.viewDeckController closeLeftViewAnimated:YES];
    
    return;
    
    switch (index)
    {
        case 0:
        {
            switch (rowNum)
            {
                case 0:
                {
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller)
                     {
                         UIViewController *apiVC = [[[MainController alloc] init] autorelease];
                         UINavigationController *navApiVC = [[[UINavigationController alloc] initWithRootViewController:apiVC] autorelease];
                         self.viewDeckController.centerController = navApiVC;
                         self.view.userInteractionEnabled = YES;
                     }];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return @"全部分类";
        }
            break;
        case 1:
        {
            return @"经典分类";
        }
            break;
        case 2:
        {
            return @"偏好分类";
        }
            break;
        default:
            return nil;
    }

}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    switch (section)
//    {
//        case 0:
//        {
//        }
//            break;
//        case 1:
//        {
//        }
//            break;
//        case 2:
//        {
//        }
//            break;
//        default:
//            return nil;
//    }
//    return nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    switch (section)
//    {
//        case 1:
//            return tableView.sectionHeaderHeight;
//        default:
//            return 0;
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
