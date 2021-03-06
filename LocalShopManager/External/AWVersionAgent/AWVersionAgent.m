//
//  AWVersionAgent.m
//  AWVersionAgent
//
//  Created by Heyward Fann on 1/31/13.
//  Copyright (c) 2013 Appwill. All rights reserved.
//

#import "AWVersionAgent.h"

#import "JSONKit.h"

#define kAppleLookupURLTemplate     @"http://itunes.apple.com/lookup?id=%@"
#define kAppStoreURLTemplate        @"itms-apps://itunes.apple.com/app/id%@"

#define kUpgradeAlertMessage    @"新版本已经发布，当前版本 %@, 最新版本: %@. 马上从appStrore更新"
#define kUpgradeAlertAction     @"kUpgradeAlertAction"
#define kUpgradeAlertDelay      3

#define kAWVersionAgentLastNotificationDateKey      @"lastNotificationDate"
#define kAWVersionAgentLastCheckVersionDateKey      @"lastCheckVersionDate"

@interface AWVersionAgent ()

@property (nonatomic, copy) NSString *appid;
@property (nonatomic) BOOL newVersionAvailable;

@end

@implementation AWVersionAgent

+ (AWVersionAgent *)sharedAgent
{
    static AWVersionAgent *sharedAgent = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAgent = [[AWVersionAgent alloc] init];
    });

    return sharedAgent;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _newVersionAvailable = NO;
        _debug = NO;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(showUpgradeNotification)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }

    return self;
}

- (void)checkNewVersionForApp:(NSString *)appid
{
    self.appid = appid;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [NSString stringWithFormat:kAppleLookupURLTemplate, _appid];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (data && [data length]>0) {
            id obj = [data objectFromJSONData];
            if (obj && [obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)obj;
                NSArray *array = dict[@"results"];
                if (array && [array count]>0) {
                    NSDictionary *app = array[0];
                    NSString *newVersion = app[@"version"];
                    NSLog(@"newVersion %@ ",newVersion);
                    [[NSUserDefaults standardUserDefaults] setObject:newVersion
                                                              forKey:@"kAppNewVersion"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    NSString *curVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
                    if (newVersion && curVersion && ![newVersion isEqualToString:curVersion]) {
                        self.newVersionAvailable = YES;
                    }
                }
            }
        }
    });
}

- (BOOL)conditionHasBeenMet
{
    if (_debug) {
        return YES;
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSTimeInterval last = [defaults doubleForKey:kAWVersionAgentLastNotificationDateKey];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    if (last <= 0) {
        [defaults setDouble:now forKey:kAWVersionAgentLastNotificationDateKey];
        [defaults synchronize];

        return NO;
    }
    if (now - last < 60*60*24) {
        return NO;
    }

    return _newVersionAvailable;
}

- (void)showUpgradeNotification
{
    if ([self conditionHasBeenMet]) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = [[NSDate date] dateByAddingTimeInterval:kUpgradeAlertDelay];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        NSString *curVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        NSString *newVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"kAppNewVersion"];
        NSString *msg = [NSString stringWithFormat:kUpgradeAlertMessage,
                         curVersion, newVersion];
        notification.alertBody = msg;
        notification.alertAction = kUpgradeAlertAction;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];

        [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970]
                                                  forKey:kAWVersionAgentLastNotificationDateKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)upgradeAppWithNotification:(UILocalNotification *)notification
{
    if ([notification.alertAction isEqualToString:kUpgradeAlertAction])
    {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];

        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:notification.alertBody
                                                        delegate:self
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:@"忽略", nil];
        [alert show];
        [alert release];

        self.newVersionAvailable = NO;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        NSString *url = [NSString stringWithFormat:kAppStoreURLTemplate, _appid];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

    }
    
}


@end
