//
//  LocalDBDataManager.m
//  LocalShopManager
//
//  Created by zhangchaoqun on 13-7-2.
//  Copyright (c) 2013年 zhangchaoqun. All rights reserved.
//

#import "LocalDBDataManager.h"
#import "FMDatabase.h"

static NSString const *makeSQL = @"PRAGMA encoding=\"UTF-8\"\n"
"CREATE TABLE local_data_info(device_uuid TEXT, "
"device_width INTEGER, "
"device_height INTEGER, "
"last_timestamp REAL, "
"os TEXT, "
"os_ver TEXT)\n"

"CREATE TABLE wa_app_info(appid TEXT PRIMARY KEY, "
"name TEXT, "
"version TEXT, "
"state INTEGER, "
"lastest_version TEXT, "
"size_unit INTEGER, "
"size INTEGER, "
"vendor TEXT, "
"icon_url TEXT, "
"released_date REAL, "
"downloaded_date REAL, "
"installed_date REAL, "
"description TEXT, "
"valid INTEGER, "
"class_mark INTEGER, "
"pkg_sign TEXT, "
"pkg_uri TEXT, "
"webState TEXT, "
"showIndex TEXT)";

@interface LocalDBDataManager()

@property (nonatomic, strong) FMDatabase *database;

@end

@implementation LocalDBDataManager

+ (id)defaultManager
{
    static LocalDBDataManager *defaultManager = nil;
    @synchronized(self) {
        if (nil == defaultManager) {
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *databasePath = [cachePath stringByAppendingPathComponent:@"localData.db"];
            defaultManager = [[LocalDBDataManager alloc]initWithLocalPath:databasePath];
        }
    }
    return defaultManager;
}

- (void)dealloc
{
    if (_database) {
        [_database close];
        [_database release];
    }
    [_localPath release];
    [super dealloc];
}

- (id)initWithLocalPath:(NSString*)localPath
{
    if (nil == localPath) {
        [self release]; self = nil;
        return self;
    }
    if ((self = [super init])) {
        _localPath = [localPath copy];
        NSFileManager *fileMan = [[[NSFileManager alloc]init]autorelease];
        if (![fileMan fileExistsAtPath:_localPath]) {
            self.database = [FMDatabase databaseWithPath:_localPath];
            [self.database open];
            NSArray *sqlLines = [makeSQL componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            for (NSString *sqlLine in sqlLines) {
                NSLog(@"init SQL:%@", sqlLine);
                [_database executeUpdate:sqlLine];
            }
        } else {
            self.database = [FMDatabase databaseWithPath:_localPath];
        }
    }
    return self;
}

#pragma mark - Public
- (NSArray*)selectObjects:(Class)persistableObjectClass where:(NSString*)where
{
    [self.database open];
    
    NSAssert([persistableObjectClass isSubclassOfClass:[WAPersistableObject class]],
             @"class:%@ must inherite from WAPersistableObject!",
             NSStringFromClass(persistableObjectClass));
    
    NSString *tableName = [persistableObjectClass tableName];
    //    NSLog(@"select * from %@", tableName);
    
    NSMutableString *SQLLine = [NSMutableString string];
    [SQLLine appendFormat:@"select * from %@", tableName];
    if (where) {
        [SQLLine appendString:@" where "];
        [SQLLine appendString:where];
    }
    FMResultSet *rs = [self.database executeQuery:SQLLine];
    NSInteger rsCount = [rs columnCount];
    NSMutableArray *rsFieldList = [NSMutableArray array];
    for (NSInteger ci = 0; ci < rsCount; ci++) {
        NSString *colName = [rs columnNameForIndex:ci];
        [rsFieldList addObject:colName];
    }
    
    NSMutableArray *resObjects = [NSMutableArray array];
    while ([rs next]) {
        WAPersistableObject *po = [[persistableObjectClass alloc]init];
        for (NSString *rsField in rsFieldList) {
            [po setValue:[rs objectForColumnName:rsField] forPersistedField:rsField];
        }
        [resObjects addObject:po];
    }
    [rs close];
    
    [self.database close];
    
    return [NSArray arrayWithArray:resObjects];
}

- (BOOL)updateObject:(WAPersistableObject*)persistableObject where:(NSString*)where
{
    NSMutableDictionary *dictionaryArgs = [NSMutableDictionary dictionary];
    NSArray *argFields = [[persistableObject class] persistedFields];
    
    if (0 == argFields.count) {
        return YES;
    }
    BOOL (^DBCreateFirstBlock)(WAPersistableObject* obj)= ^(WAPersistableObject * obj){
        [self.database open];
        
        NSMutableString *SQLLine = [NSMutableString string];
        [SQLLine appendFormat:@"update %@ set ", [[persistableObject class] tableName]];
        NSString *prefix = @"";
        for (NSString *argField in argFields) {
            id value = [persistableObject valueForPersistedField:argField];
            if (value) {
                [SQLLine appendFormat:@"%@ %@=:%@", prefix, argField, argField];
                [dictionaryArgs setObject:[persistableObject valueForPersistedField:argField]
                                   forKey:argField];
                prefix = @",";
            }
        }
        [SQLLine appendString:@" "];
        if (where) {
            [SQLLine appendString:where];
        } else {
            NSString *prefix = @"where ";
            NSArray *primaryKeys = [[persistableObject class] primaryKeyFields];
            if ([primaryKeys count]) {
                for (NSString *primaryKey in primaryKeys) {
                    
                    id value = [persistableObject valueForPersistedField:primaryKey];
                    if (value) {
                        [SQLLine appendString:prefix];
                        if ([value isKindOfClass:[NSString class]]) {
                            [SQLLine appendFormat:@"%@='%@'", primaryKey, value];
                        } else {
                            [SQLLine appendFormat:@"%@=%@", primaryKey, value];
                        }
                        prefix = @" and ";
                    }
                }
            }
        }
        NSLog(@"更新SQL:%@\n%@", SQLLine, dictionaryArgs);
        //    NSString *version = dictionaryArgs[@"version"];
        //    NSLog(@"version:%@", version);
        
        BOOL res = [self.database executeUpdate:SQLLine withParameterDictionary:dictionaryArgs];
        
        [self.database close];
        
        return res;

    };
    
    
    BOOL last = [self checkAndCreateTableForObject:persistableObject andBlock:DBCreateFirstBlock];
    return last;
}

- (BOOL)insertObject:(WAPersistableObject*)persistableObject
{
    NSMutableDictionary *dictionaryArgs = [NSMutableDictionary dictionary];
    NSArray *argFields = [[persistableObject class] persistedFields];
    
    if (0 == argFields.count) {
        return YES;
    }
    
    BOOL (^DBCreateFirstBlock)(WAPersistableObject* obj)= ^(WAPersistableObject * obj){
        [self.database open];
        
        NSMutableString *SQLLine = [NSMutableString string];
        [SQLLine appendFormat:@"insert into %@ values (", [[persistableObject class] tableName]];
        NSString *prefix = @"";
        for (NSString *argField in argFields) {
            id value = [persistableObject valueForPersistedField:argField];
            if (value) {
                [SQLLine appendFormat:@"%@ :%@", prefix, argField];
                [dictionaryArgs setObject:[persistableObject valueForPersistedField:argField]
                                   forKey:argField];
                prefix = @",";
            }
        }
        [SQLLine appendString:@")"];
        NSLog(@"插入SQL:%@ \n%@", SQLLine, dictionaryArgs);
        BOOL res = [self.database executeUpdate:SQLLine withParameterDictionary:dictionaryArgs];
        NSAssert(res, @"failed to insert:%@", self.database.lastError);
        
        [self.database close];
        return res;

    };
    
    BOOL last = [self checkAndCreateTableForObject:persistableObject andBlock:DBCreateFirstBlock];
    return last;
}

- (BOOL)deleteObject:(WAPersistableObject*)persistableObject
{
    NSMutableDictionary *dictionaryArgs = [NSMutableDictionary dictionary];
    NSArray *argFields = [[persistableObject class] persistedFields];
    
    if (0 == argFields.count) {
        return YES;
    }
    
    

     BOOL (^DBCreateFirstBlock)(WAPersistableObject* obj)= ^(WAPersistableObject * obj){
        [self.database open];
        NSMutableString *SQLLine = [NSMutableString string];
        [SQLLine appendFormat:@"delete from %@ ", [[persistableObject class] tableName]];
        [SQLLine appendString:@" "];
        NSArray *primaryKeys = [[persistableObject class] primaryKeyFields];
        if ([primaryKeys count]) {
            NSString *prefix = @"where ";
            for (NSString *primaryKey in primaryKeys) {
                id value = [persistableObject valueForPersistedField:primaryKey];
                if (value) {
                    [SQLLine appendString:prefix];
                    if ([value isKindOfClass:[NSString class]]) {
                        [SQLLine appendFormat:@"%@='%@'", primaryKey, value];
                    } else {
                        [SQLLine appendFormat:@"%@=%@", primaryKey, value];
                    }
                    prefix = @" and ";
                }
            }
        }
        NSLog(@"更新SQL:%@\n%@", SQLLine, dictionaryArgs);
        
        BOOL res = [self.database executeUpdate:SQLLine withParameterDictionary:dictionaryArgs];
        [self.database close];
         
        return res;
    };
    
    BOOL last = [self checkAndCreateTableForObject:persistableObject andBlock:DBCreateFirstBlock];
    

    
    return last;
}
-(BOOL)checkAndCreateTableForObject:(WAPersistableObject *)persistableObject andBlock:(BOOL(^)(WAPersistableObject *obj))block
{
    
    NSString * tableName = [[persistableObject class] tableName];
    if (![self isTableOK:tableName])
    {
        NSString * sql = [[persistableObject class] createTableSQL];
        [self createTableWithCreateSQL:sql];
    }
    
    
    
    BOOL blockResult = block(persistableObject);
    
    return blockResult;
}

-(void)createTableWithCreateSQL:(NSString *)tableSQL
{
    [self.database open];
    NSArray *sqlLines = [tableSQL componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    for (NSString *sqlLine in sqlLines) {
        NSLog(@"init SQL:%@", sqlLine);
        [_database executeUpdate:sqlLine];
    }
    [self.database close];
}

// 判断是否存在表
- (BOOL) isTableOK:(NSString *)tableName
{
    [self.database open];
    FMResultSet *rs = [self.database executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        NSLog(@" %@ isTableOK %d 0为不存在",tableName, count);
        
        if (0 == count)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    [self.database close];
    return NO;
}



@end


