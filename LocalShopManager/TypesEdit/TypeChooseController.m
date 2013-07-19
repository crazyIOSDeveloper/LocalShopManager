//
//  TypeChooseController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-16.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "TypeChooseController.h"

#import "TypeEditingCell.h"
#import "TypeSelectCell.h"
#import "TypeDataObj.h"

#import "UserSortsObject.h"
#import "LoginController.h"

@interface TypeChooseController ()

@end

@implementation TypeChooseController
@synthesize dataArr;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"类型选择";
        UIButton * right = [self normalBtnForNavigationBarRight];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:right] autorelease];
        
    }
    return self;
}
- (void)tableViewEdit:(id)sender{
    
    UIButton * btn = (UIButton *)sender;
    [_tableView setEditing:!_tableView.editing animated:YES];
    BOOL editing =_tableView.editing;
    
    
    if (editing)
    {
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        if (!editDlgObj)
        {
            editDlgObj = [[TypeEditViewDelegate alloc] initWithArray:self.dataArr andDelegate:self];
        }
        NSArray * showArr = [selectDlbObj tableShowDataArr];
        [editDlgObj startWithShowArray:showArr];
        
        _tableView.dataSource = editDlgObj;
        _tableView.delegate = editDlgObj;
        
        NSIndexSet * set = [NSIndexSet indexSetWithIndex:1];
        [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        
        NSArray * array = [_tableView indexPathsForVisibleRows];
        [_tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
        [_tableView reloadData];
        
        [selectDlbObj release];
        selectDlbObj = nil;
        
    }else
    {
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [editDlgObj stopTypeNameEdit];
        
        NSArray * total = [editDlgObj endEditTypeWithNowTypeData];
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:total];
        
        
        [self saveNowSortTypesArray:nil];
        
        if (!selectDlbObj)
        {
            selectDlbObj = [[TypeSelectViewDelegate alloc] initWithArray:self.dataArr andDelegate:self];
        }
        NSArray * showArr = [editDlgObj tableShowDataArr];
        [selectDlbObj startWithShowArray:showArr];
        
        _tableView.dataSource = selectDlbObj;
        _tableView.delegate = selectDlbObj;

        NSIndexSet * set = [NSIndexSet indexSetWithIndex:1];
        [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];

        
        NSArray * array = [_tableView indexPathsForVisibleRows];
        [_tableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
        [_tableView reloadData];
        
        
        [editDlgObj release];
        editDlgObj = nil;
    }
}
-(UIButton *)normalBtnForNavigationBarRight
{
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"Common/NavigationButtonBG.png" bundleName:BUNDLE_NAME]
                       forState:UIControlStateNormal];
    
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    
    [rightBtn addTarget:self action:@selector(tableViewEdit:) forControlEvents:UIControlEventTouchUpInside];
    return rightBtn;
}

-(void)saveNowSortTypesArray:(id)sender
{
    //数据库处理
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        LocalDBDataManager * manager = [LocalDBDataManager defaultManager];
        [manager selectObjects:[UserSortsObject class] where:nil];
        NSArray * totalArray = self.dataArr;
        [TypeDataObj showNamesFromArr:totalArray];


        //此数据 仅有子类型数组，没有名称        //全部数据，根数据结构
        NSArray * objArr = [TypeDataObj totalRootTypeObjsArrFromTotalDataArray:totalArray];
        NSMutableArray * jsonArr = [NSMutableArray array];
        for (TypeDataObj * obj in objArr )
        {
            NSDictionary * jsonDic = [obj jsonDic];
            [jsonArr addObject:jsonDic];
        }
        NSString * jsonStr = [jsonArr JSONString];
        NSLog(@"存储json %@",jsonStr);

        UserSortsObject * sort = [[UserSortsObject alloc] init];
        sort.sortsShopId_ = [NSString stringWithFormat:@"%@",[[NSDate date] description]];
        sort.lastDate_= [[NSDate date] description];
        sort.sortsStruct_ = jsonStr;
        sort.personIdStr_ = @"未登录";

        LoginController * login = [LoginController sharedLoginController];
        NSString * idStr = login.loginTel;
        if (idStr)
        {
            sort.personIdStr_ = idStr;
        }
        
        [manager insertObject:sort];
    });
    
}

-(void)readLocalSortTypes:(id)sender
{
    LocalDBDataManager * manager = [LocalDBDataManager defaultManager];
    NSArray * array = [manager selectObjects:[UserSortsObject class] where:nil];
    
    UserSortsObject * sortData = [array lastObject];
    NSString * structStr = sortData.sortsStruct_;
    
    NSLog(@"使用json %@",structStr);
    NSArray * objJsonArr = [structStr objectFromJSONString];
    NSMutableArray * totalArr = [NSMutableArray array];
    for (NSDictionary * dic in objJsonArr)
    {
        TypeDataObj * eveObj = [TypeDataObj totalTypeDataFromJSONDic:dic];
        NSArray * subTotal = [eveObj totalSubTypesArray];
        [totalArr addObjectsFromArray:subTotal];
    }
        
    
    if (!totalArr||[totalArr count]==0)
    {
//        return ;
        TypeDataObj * typeData = [TypeDataObj normalTypeObj];
        NSArray * normalArr = [typeData totalSubTypesArray];
        [totalArr addObjectsFromArray:normalArr];
    }
    self.dataArr = [NSMutableArray arrayWithArray:totalArr];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [editDlgObj setSourceArray:totalArr];
        [selectDlbObj setSourceArray:totalArr];
        
        [_tableView reloadData];
    });

    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
            });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self readLocalSortTypes:nil];

    //首次初始化数据，应该由数据库读取
    selectDlbObj = [[TypeSelectViewDelegate alloc] initWithArray:nil andDelegate:self];
    
    CGRect rect = [self showViewBoundsWithTabBarShow:NO];
    //    rect.size.height = rect.size.height/2.0;
//    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];

    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = selectDlbObj;
    _tableView.dataSource = selectDlbObj;
    _tableView.allowsSelectionDuringEditing = YES;
//    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(tableViewEdit:)];
    
}
#pragma mark TypeSelectDelegate
-(void)endSelectWithChooseTypeArray:(NSArray *)array
{
    NSLog(@"endSelectWithChooseTypeArray %@ ",array);
}
-(UITableView *)tableViewForTypeSelectDelegate
{
    return _tableView;
}
#pragma mark TypeEditDelegate
-(UITableView *)tableViewForTypeEditDelegate
{
    return _tableView;
}

#pragma mark -UITableViewDelegate--


#pragma mark -------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
