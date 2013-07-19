//
//  MainController.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-6-30.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "MainController.h"
#import "WelcomeController.h"
#import "OWActivityViewController.h"
#import "LocalDBDataManager.h"

#import "CustomTabItem.h"
#import "CustomSelectionView.h"
#import "CustomBackgroundLayer.h"
#import <ShareSDK/ShareSDK.h>
#import "GTLoadingViewController.h"
#import "WAPersistableObject.h"
#import "MainContentsCell.h"
#import "TypeChooseController.h"

#define Main_Content_CELL @"Main_Content_CELL"
@interface MainController ()

@end

@implementation MainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       self.title = @"主页";
        _showArr = [[NSMutableArray alloc] init];
        NSArray * urlArr = @[
                     @"https://lh6.googleusercontent.com/-jZgveEqb6pg/T3R4kXScycI/AAAAAAAAAE0/xQ7CvpfXDzc/s1024/sample_image_01.jpg",
                     @"https://lh4.googleusercontent.com/-K2FMuOozxU0/T3R4lRAiBTI/AAAAAAAAAE8/a3Eh9JvnnzI/s1024/sample_image_02.jpg",
                     @"https://lh5.googleusercontent.com/-SCS5C646rxM/T3R4l7QB6xI/AAAAAAAAAFE/xLcuVv3CUyA/s1024/sample_image_03.jpg",
                     @"https://lh6.googleusercontent.com/-f0NJR6-_Thg/T3R4mNex2wI/AAAAAAAAAFI/45oug4VE8MI/s1024/sample_image_04.jpg",
                     @"https://lh3.googleusercontent.com/-n-xcJmiI0pg/T3R4mkSchHI/AAAAAAAAAFU/EoiNNb7kk3A/s1024/sample_image_05.jpg",
                     @"https://lh3.googleusercontent.com/-X43vAudm7f4/T3R4nGSChJI/AAAAAAAAAFk/3bna6D-2EE8/s1024/sample_image_06.jpg",
                     @"https://lh5.googleusercontent.com/-MpZneqIyjXU/T3R4nuGO1aI/AAAAAAAAAFg/r09OPjLx1ZY/s1024/sample_image_07.jpg",
                     @"https://lh6.googleusercontent.com/-ql3YNfdClJo/T3XvW9apmFI/AAAAAAAAAL4/_6HFDzbahc4/s1024/sample_image_08.jpg",
                     @"https://lh5.googleusercontent.com/-Pxa7eqF4cyc/T3R4oasvPEI/AAAAAAAAAF0/-uYDH92h8LA/s1024/sample_image_09.jpg",
                     @"https://lh4.googleusercontent.com/-Li-rjhFEuaI/T3R4o-VUl4I/AAAAAAAAAF8/5E5XdMnP1oE/s1024/sample_image_10.jpg",
                     @"https://lh5.googleusercontent.com/-_HU4fImgFhA/T3R4pPVIwWI/AAAAAAAAAGA/0RfK_Vkgth4/s1024/sample_image_11.jpg",
                     @"https://lh6.googleusercontent.com/-0gnNrVjwa0Y/T3R4peGYJwI/AAAAAAAAAGU/uX_9wvRPM9I/s1024/sample_image_12.jpg",
                     @"https://lh3.googleusercontent.com/-HBxuzALS_Zs/T3R4qERykaI/AAAAAAAAAGQ/_qQ16FaZ1q0/s1024/sample_image_13.jpg",
                     @"https://lh4.googleusercontent.com/-cKojDrARNjQ/T3R4qfWSGPI/AAAAAAAAAGY/MR5dnbNaPyY/s1024/sample_image_14.jpg",
                     @"https://lh3.googleusercontent.com/-WujkdYfcyZ8/T3R4qrIMGUI/AAAAAAAAAGk/277LIdgvnjg/s1024/sample_image_15.jpg",
                     @"https://lh6.googleusercontent.com/-FMHR7Vy3PgI/T3R4rOXlEKI/AAAAAAAAAGs/VeXrDNDBkaw/s1024/sample_image_16.jpg",
                     @"https://lh4.googleusercontent.com/-mrR0AJyNTH0/T3R4rZs6CuI/AAAAAAAAAG0/UE1wQqCOqLA/s1024/sample_image_17.jpg",
                     @"https://lh6.googleusercontent.com/-z77w0eh3cow/T3R4rnLn05I/AAAAAAAAAG4/BaerfWoNucU/s1024/sample_image_18.jpg",
                     @"https://lh5.googleusercontent.com/-aWVwh1OU5Bk/T3R4sAWw0yI/AAAAAAAAAHE/4_KAvJttFwA/s1024/sample_image_19.jpg",
                     @"https://lh6.googleusercontent.com/-q-js52DMnWQ/T3R4tZhY2sI/AAAAAAAAAHM/A8kjp2Ivdqg/s1024/sample_image_20.jpg",
                     @"https://lh5.googleusercontent.com/-_jIzvvzXKn4/T3R4t7xpdVI/AAAAAAAAAHU/7QC6eZ10jgs/s1024/sample_image_21.jpg",
                     @"https://lh3.googleusercontent.com/-lnGi4IMLpwU/T3R4uCMa7vI/AAAAAAAAAHc/1zgzzz6qTpk/s1024/sample_image_22.jpg",
                     @"https://lh5.googleusercontent.com/-fFCzKjFPsPc/T3R4u0SZPFI/AAAAAAAAAHk/sbgjzrktOK0/s1024/sample_image_23.jpg",
                     @"https://lh4.googleusercontent.com/-8TqoW5gBE_Y/T3R4vBS3NPI/AAAAAAAAAHs/EZYvpNsaNXk/s1024/sample_image_24.jpg",
                     @"https://lh6.googleusercontent.com/-gc4eQ3ySdzs/T3R4vafoA7I/AAAAAAAAAH4/yKii5P6tqDE/s1024/sample_image_25.jpg",
                     @"https://lh5.googleusercontent.com/--NYOPCylU7Q/T3R4vjAiWkI/AAAAAAAAAH8/IPNx5q3ptRA/s1024/sample_image_26.jpg",
                     @"https://lh6.googleusercontent.com/-9IJM8so4vCI/T3R4vwJO2yI/AAAAAAAAAIE/ljlr-cwuqZM/s1024/sample_image_27.jpg",
                     @"https://lh4.googleusercontent.com/-KW6QwOHfhBs/T3R4w0RsQiI/AAAAAAAAAIM/uEFLVgHPFCk/s1024/sample_image_28.jpg",
                     @"https://lh4.googleusercontent.com/-z2557Ec1ctY/T3R4x3QA2hI/AAAAAAAAAIk/9-GzPL1lTWE/s1024/sample_image_29.jpg",
                     @"https://lh5.googleusercontent.com/-LaKXAn4Kr1c/T3R4yc5b4lI/AAAAAAAAAIY/fMgcOVQfmD0/s1024/sample_image_30.jpg",
                     @"https://lh4.googleusercontent.com/-F9LRToJoQdo/T3R4yrLtyQI/AAAAAAAAAIg/ri9uUCWuRmo/s1024/sample_image_31.jpg",
                     @"https://lh4.googleusercontent.com/-6X-xBwP-QpI/T3R4zGVboII/AAAAAAAAAIs/zYH4PjjngY0/s1024/sample_image_32.jpg",
                     @"https://lh5.googleusercontent.com/-VdLRjbW4LAs/T3R4zXu3gUI/AAAAAAAAAIw/9aFp9t7mCPg/s1024/sample_image_33.jpg",
                     @"https://lh6.googleusercontent.com/-gL6R17_fDJU/T3R4zpIXGjI/AAAAAAAAAI8/Q2Vjx-L9X20/s1024/sample_image_34.jpg",
                     @"https://lh3.googleusercontent.com/-1fGH4YJXEzo/T3R40Y1B7KI/AAAAAAAAAJE/MnTsa77g-nk/s1024/sample_image_35.jpg",
                     @"https://lh4.googleusercontent.com/-Ql0jHSrea-A/T3R403mUfFI/AAAAAAAAAJM/qzI4SkcH9tY/s1024/sample_image_36.jpg",
                     @"https://lh5.googleusercontent.com/-BL5FIBR_tzI/T3R41DA0AKI/AAAAAAAAAJk/GZfeeb-SLM0/s1024/sample_image_37.jpg",
                     @"https://lh4.googleusercontent.com/-wF2Vc9YDutw/T3R41fR2BCI/AAAAAAAAAJc/JdU1sHdMRAk/s1024/sample_image_38.jpg",
                     @"https://lh6.googleusercontent.com/-ZWHiPehwjTI/T3R41zuaKCI/AAAAAAAAAJg/hR3QJ1v3REg/s1024/sample_image_39.jpg",
                     // Light images
                     @"http://tabletpcssource.com/wp-content/uploads/2011/05/android-logo.png",
                     @"http://simpozia.com/pages/images/stories/windows-icon.png",
                     @"https://si0.twimg.com/profile_images/1135218951/gmail_profile_icon3_normal.png",
                     @"http://www.krify.net/wp-content/uploads/2011/09/Macromedia_Flash_dock_icon.png",
                     @"http://radiotray.sourceforge.net/radio.png",
                     @"http://www.bandwidthblog.com/wp-content/uploads/2011/11/twitter-logo.png",
                     @"http://weloveicons.s3.amazonaws.com/icons/100907_itunes1.png",
                     @"http://thecustomizewindows.com/wp-content/uploads/2011/11/Nicest-Android-Live-Wallpapers.png",
                     @"http://c.wrzuta.pl/wm16596/a32f1a47002ab3a949afeb4f",
                     @"http://macprovid.vo.llnwd.net/o43/hub/media/1090/6882/01_headline_Muse.jpg",
                     @"https://www.eff.org/sites/default/files/chrome150_0.jpg", // Image from HTTPS
                     @"http://img001.us.expono.com/100001/100001-1bc30-2d736f_m.jpg"];
        
        [_showArr addObjectsFromArray:urlArr];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self showWelcomeView:nil];
    
    
    [self dataFromLocalDB:nil];
    [self addCustomTabView];
    
       
    self.view.backgroundColor = [UIColor colorWithRGB:0xe1e0de];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.width, self.view.height-49.0)
                                              style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 32;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;

    _tableView.scrollsToTop = YES;
    [self.view addSubview:_tableView];
    [_tableView release];

    
    [self showTestButton:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
//    [LSMToolen showSubViewsOfView:self.view.window];
}

-(void)showTestButton:(id)sender
{
    CGRect rect = self.view.bounds;
    rect.size.height -=49;
    rect.size.height -=44;
    lastContentView= [[UIView alloc] initWithFrame:rect];
    [self.view addSubview:lastContentView];
    lastContentView.hidden = YES;
    
    UIButton * zbarBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    zbarBtn.frame = CGRectMake(20, 80, 280, 44);
    [zbarBtn setTitle:@"Show OWActivityViewController" forState:UIControlStateNormal];
    [zbarBtn addTarget:self action:@selector(showSelectActivityView:) forControlEvents:UIControlEventTouchUpInside];
    [lastContentView addSubview:zbarBtn];
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    shareBtn.frame = CGRectMake(20, 150, 280, 44);
    [shareBtn setTitle:@"Show Zbar" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(showZbar:) forControlEvents:UIControlEventTouchUpInside];
    [lastContentView addSubview:shareBtn];

    UIButton * chooseTypeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    chooseTypeBtn.frame = CGRectMake(20, 220, 280, 44);
    [chooseTypeBtn setTitle:@"Show Type Choose" forState:UIControlStateNormal];
    [chooseTypeBtn addTarget:self action:@selector(showTypeChoose:) forControlEvents:UIControlEventTouchUpInside];
    [lastContentView addSubview:chooseTypeBtn];

    
}


-(void)showTypeChoose:(id)sender
{
    UIViewController * choose = [FactoryController chooseTypeContrllerWithSender:nil];
    [self pushNextController:choose withMainScrollEnabled:NO];
    
}

-(void)showZbar:(id)sender
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    [self presentModalViewController: reader
                            animated: YES];
    [reader release];

}
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:imageview];
    [imageview release];
    
    imageview.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    [reader dismissModalViewControllerAnimated: YES];
    
    //判断是否包含 头'http:'
    NSString *regex = @"http+:[^\\s]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    //判断是否包含 头'ssid:'
    NSString *ssid = @"ssid+:[^\\s]*";;
    NSPredicate *ssidPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ssid];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,300 , 100, 50)];
    [self.view addSubview:label];
    [label release];
    
    label.text =  symbol.data ;
    
    if ([predicate evaluateWithObject:label.text]) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil
                                                        message:@"It will use the browser to this URL。"
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:@"Ok", nil];
        alert.delegate = self;
        alert.tag=1;
        [alert show];
        [alert release];
        
        
        
    }
    else if([ssidPre evaluateWithObject:label.text]){
        
        NSArray *arr = [label.text componentsSeparatedByString:@";"];
        
        NSArray * arrInfoHead = [[arr objectAtIndex:0] componentsSeparatedByString:@":"];
        
        NSArray * arrInfoFoot = [[arr objectAtIndex:1] componentsSeparatedByString:@":"];
        
        
        label.text=
        [NSString stringWithFormat:@"ssid: %@ \n password:%@",
         [arrInfoHead objectAtIndex:1],[arrInfoFoot objectAtIndex:1]];
        
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:label.text
                                                        message:@"The password is copied to the clipboard , it will be redirected to the network settings interface"
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:@"Ok", nil];
        
        
        alert.delegate = self;
        alert.tag=2;
        [alert show];
        [alert release];
        
        UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
        //        然后，可以使用如下代码来把一个字符串放置到剪贴板上：
        pasteboard.string = [arrInfoFoot objectAtIndex:1];
        
        
    }
}


-(void)addCustomTabView;
{
    JMTabView * tabView = [[[JMTabView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60., self.view.bounds.size.width, 60.)] autorelease];
    tabView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    
    [tabView setDelegate:self];
    
    UIImage * standardIcon = [UIImage imageNamed:@"icon3.png"];
    UIImage * highlightedIcon = [UIImage imageNamed:@"icon2.png"];
    
    CustomTabItem * tabItem1 = [CustomTabItem tabItemWithTitle:@"One" icon:standardIcon alternateIcon:highlightedIcon];
    CustomTabItem * tabItem2 = [CustomTabItem tabItemWithTitle:@"Two" icon:standardIcon alternateIcon:highlightedIcon];
    CustomTabItem * tabItem3 = [CustomTabItem tabItemWithTitle:@"Three" icon:standardIcon alternateIcon:highlightedIcon];
    CustomTabItem * tabItem4 = [CustomTabItem tabItemWithTitle:@"Four" icon:standardIcon alternateIcon:highlightedIcon];
    CustomTabItem * tabItem5 = [CustomTabItem tabItemWithTitle:@"Five" icon:standardIcon alternateIcon:highlightedIcon];
    
    [tabView addTabItem:tabItem1];
    [tabView addTabItem:tabItem2];
    [tabView addTabItem:tabItem3];
    [tabView addTabItem:tabItem4];
    [tabView addTabItem:tabItem5];
    
    [tabView setSelectionView:[CustomSelectionView createSelectionView]];
    [tabView setItemSpacing:1.];
    [tabView setBackgroundLayer:[[[CustomBackgroundLayer alloc] init] autorelease]];
    
    [tabView setSelectedIndex:0];
    
    [self.view addSubview:tabView];
}

-(void)dataFromLocalDB:(id)sender
{
    //此处，建议做数据库同步，或者数据预加载
    
    //数据库相关
//    LocalDBDataManager * local = [LocalDBDataManager defaultManager];
//    
//    PurchaserDataObject * obj = [[PurchaserDataObject alloc] init];
    
    
    
}



-(void)showSelectActivityView:(id)sender
{
    //尚未考虑内存释放
    
    OWTwitterActivity *twitterActivity = [[OWTwitterActivity alloc] init];
    OWMailActivity *mailActivity = [[OWMailActivity alloc] init];
    OWSafariActivity *safariActivity = [[OWSafariActivity alloc] init];
    OWSaveToCameraRollActivity *saveToCameraRollActivity = [[OWSaveToCameraRollActivity alloc] init];
    OWMapsActivity *mapsActivity = [[OWMapsActivity alloc] init];
    OWPrintActivity *printActivity = [[OWPrintActivity alloc] init];
    OWCopyActivity *copyActivity = [[OWCopyActivity alloc] init];
    
    // Create some custom activity
    //
    OWActivity *customActivity = [[OWActivity alloc] initWithTitle:@"Custom"
                                                             image:[UIImage imageNamed:@"OWActivityViewController.bundle/Icon_Custom"]
                                                       actionBlock:^(OWActivity *activity, OWActivityViewController *activityViewController) {
                                                           [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                               NSLog(@"Info: %@", activityViewController.userInfo);
                                                           }];
                                                       }];
    
    // Compile activities into an array, we will pass that array to
    // OWActivityViewController on the next step
    //
    
    NSMutableArray *activities = [NSMutableArray arrayWithObject:mailActivity];
    
    // For some device may not support message (ie, Simulator and iPod Touch).
    // There is a bug in the Simulator when you configured iMessage under OS X,
    // for detailed information, refer to: http://stackoverflow.com/questions/9349381/mfmessagecomposeviewcontroller-on-simulator-cansendtext
    if ([MFMessageComposeViewController canSendText]) {
        OWMessageActivity *messageActivity = [[OWMessageActivity alloc] init];
        [activities addObject:messageActivity];
    }
    
    [activities addObjectsFromArray:@[saveToCameraRollActivity, twitterActivity]];
    
    if( NSClassFromString (@"UIActivityViewController") ) {
        // ios 6, add facebook and sina weibo activities
        OWFacebookActivity *facebookActivity = [[OWFacebookActivity alloc] init];
        OWSinaWeiboActivity *sinaWeiboActivity = [[OWSinaWeiboActivity alloc] init];
        [activities addObjectsFromArray:@[
         facebookActivity, sinaWeiboActivity
         ]];
    }
    
    [activities addObjectsFromArray:@[
     safariActivity, mapsActivity, printActivity, copyActivity, customActivity]];
    
    // Create OWActivityViewController controller and assign data source
    //
    OWActivityViewController *activityViewController = [[OWActivityViewController alloc] initWithViewController:self activities:activities];
    
        //非ARC下，以下语句有问题
//    activityViewController.userInfo = @{
//                                        @"image":[UIImage imageNamed:@"Flower.jpg"],
//                                        @"text": @"Hello world!",
//                                        @"url": [NSURL URLWithString:@"https://github.com/romaonthego/OWActivityViewController"],
//                                        @"coordinate": @{@"latitude": @(37.751586275), @"longitude": @(-122.447721511)}
//                                        };
    
    [activityViewController presentFromRootViewController];
}



-(void)showWelcomeView:(id)sender
{
    GTLoadingViewController * load = [[GTLoadingViewController alloc] init];
//    [self presentModalViewController:load animated:NO];
    [self presentViewController:load animated:NO completion:nil];
    [load release];
    
    
    
    //欢迎界面
//    WelcomeController * welcom = [[WelcomeController alloc] init];
//    [self presentViewController:welcom animated:NO completion:nil];
//    [welcom release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideWelcomeViewDone:)
                                                 name:WelComeViewHideDoneNotifice
                                               object:nil];
    
}

-(void)hideWelcomeViewDone:(NSNotification*)sender
{
    NSDictionary *dict = [sender userInfo];
    NSLog(@"hideWelcomeViewDone%@ %@",dict,sender);
}

#pragma mark JMTabViewDelegate
-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex;
{
    NSLog(@"Selected Tab Index: %d", itemIndex);
    int index = itemIndex;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if(index==4)
    {
        _tableView.alpha = 1.0;
        [self showTestBtn:nil];
        _tableView.hidden= YES;
        
        _tableView.alpha = 0.0;
    }else
    {
        _tableView.alpha = 0.0;
        [self hiddenTestBtn:nil];
        _tableView.hidden = NO;
        _tableView.alpha = 1.0;
    }
    [UIView commitAnimations];
    

    
    
}
-(void)showTestBtn:(id)sender
{
    lastContentView.alpha = 0.0;
    lastContentView.hidden = NO;
    lastContentView.alpha = 1.0;
}
-(void)hiddenTestBtn:(id)sender
{
    lastContentView.alpha = 1.0;
    lastContentView.hidden = YES;
    lastContentView.alpha = 0.0;
}

#pragma ------------------------
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_showArr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
//    int index = indexPath.row;
    cell = [[[NSBundle mainBundle] loadNibNamed:@"MainContentsCell" owner:nil options:nil] lastObject];

    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
//    int section = indexPath.section;
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:Main_Content_CELL];
    if (cell == nil)
    {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MainContentsCell" owner:nil options:nil] lastObject];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
        //        cell.textLabel.textColor = [UIColor colorWithRGB:0xc3c3c2];
        
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        lineView.frame = CGRectMake(0.0, cell.contentView.height - lineView.height , cell.contentView.width, lineView.height);
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell addSubview:lineView];
        [lineView release];
    }
    NSString * urlStr = [_showArr objectAtIndex:index];
    NSURL * url = [NSURL URLWithString:urlStr];
    MainContentsCell * content = (MainContentsCell *)cell;
    [content.showImgView setImageWithURL:url withPalceholderImage:[UIImage imageNamed:@"blinky.png"]];
    content.showTxtLbl.text = urlStr;
    
    content.indentationLevel = index%2;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self prepareImgsForFollowCells:3 withStart:index];
    });
    
    return cell;
}
-(void)prepareImgsForFollowCells:(int)number withStart:(int)index
{
    
    NSAutoreleasePool * _pool = [[NSAutoreleasePool alloc] init];
    for (int i=0;i<number;i++ )
    {
        //特殊处理
        NSString * nextUrlStr = nil;
        if ([_showArr count]>index+i)
        {
            nextUrlStr = [_showArr objectAtIndex:index+i];
        }
        NSURL * nextUrl = [NSURL URLWithString:nextUrlStr];
        UIImageView * img = [[UIImageView alloc] init];
        [img setImageWithURL:nextUrl];
        [img release];
    }
    [_pool drain];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    
    return YES;
    
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
}



#pragma ------------------------
-(void)dealloc
{
    [lastContentView release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
