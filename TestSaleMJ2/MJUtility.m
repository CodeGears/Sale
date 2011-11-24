//
//  MJUtility.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/21/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "MJUtility.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@implementation MJUtility

static MJUtility* _sharedInstance = nil;

#pragma mark- Singleton method
+ (id) sharedInstance{
    @synchronized(self){
        if (_sharedInstance == nil) {
            _sharedInstance = [[[self class] alloc] init];
            
                    }
    }
    return _sharedInstance;
}


-(void)dealloc{
       
    [_sharedInstance release];
    [super dealloc];
}
- (NSString*)getDBPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"MJ1.db"];
    return path;
    
}

// convert string date from database to NSDate

-(NSDate*) convertStringDateToNSDate: (NSString*)stringDate
{
       // [stringDate substringToIndex:10];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];  
    
    NSDate *date = [dateFormatter dateFromString:stringDate];
    //NSLog(@"Converted %@",[date description] );
    [dateFormatter release];
    return date; 
    
}

-(NSString*) getPicklistValueFromTable: (NSString*) table resultColumn: (NSString*) resCol codeColumn:(NSString*) codeCol code: (NSString*) code {
    if (![code isEqualToString:nil]){
    
        FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
        
        [database open];
        
        NSString* result = [database stringForQuery:[NSString stringWithFormat: @"select %@ from %@ WHERE %@ = '%@'", resCol, table, codeCol, code  ]];
       
         [database close];
        return result;
        
       
        
    }else return nil;
    
}

//convert NDDate to String before put in database 

- (NSString*)convertNSDateToString: (NSDate*) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *formattedStringDate = [dateFormatter stringFromDate:date];
    
    [dateFormatter release];
    return formattedStringDate;
    
}
- (UIImage*)convertNSDataToUIImage: (NSData*) data
{
    UIImage* image = [UIImage imageWithData: data];
    return image;
}

-(NSString*) getMJConfigInfo: (NSString*) key{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *configFinalPath = [docsPath stringByAppendingPathComponent: @"MJConfig.plist"]; 
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: configFinalPath ];
    return [data objectForKey:key];

}


// call when program start 
-(void) initializeDB
{   //get path that database exist and send to FMDB to generate if none if Exist use this DB
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsPath = [paths objectAtIndex:0];
    
    [docsPath retain];
    
    // find MjConfig path
    
    NSError *error;
    
    NSString *configFinalPath = [docsPath stringByAppendingPathComponent: @"MJConfig.plist"]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    //copy from bundle to Document Directories if MJConfig not exsit in the directory
    
    if (![fileManager fileExistsAtPath: configFinalPath]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource: @"MJConfig" ofType: @"plist"]; 
        
        [fileManager copyItemAtPath:bundle toPath: configFinalPath error:&error]; //6
    }
    
    
    //Acllocate data fron MJConfig
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: configFinalPath ];
    
    
    //find database path
    
    NSString *path = [docsPath stringByAppendingPathComponent:@"MJ1.db"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path]; 
    
    [database open];
    
    //Get basic information from database to MJConfig.plist
    
    FMResultSet *results = [database executeQuery:@"select territory_code, territory_name, territory_description, rep_code from mst_territory"];
    while([results next]) {
        
        [data setObject: [results stringForColumn:@"territory_code"] forKey:@"TerritoryCode"];
        [data setObject: [results stringForColumn:@"territory_name"] forKey:@"TerritoryName"];
        [data setObject: [results stringForColumn:@"territory_description"] forKey:@"TerritoryDescription"];
        [data setObject: [results stringForColumn:@"rep_code"] forKey:@"SalesCode"];
        //[data setObject:[NSNumber numberWithInt:value] forKey:@"value"];
        
               
        NSLog(@"Initialize Salescode : %@ ",[data objectForKey:@"SalesCode"]);
        
    }
    
    results = [database executeQuery:@"select variable, value from mst_environment where variable = 'CALLBACKTIME'"];
    while([results next]) {
        
        [data setObject: [results stringForColumn:@"value"] forKey:@"CallBackTime"];
               
    }
    
    results = [database executeQuery:@"select variable, value from mst_environment where variable = 'PURGEDAY'"];
    while([results next]) {
        
        [data setObject: [results stringForColumn:@"value"] forKey:@"PurgeDay"];
        
    }
    

    
    results = [database executeQuery:@"select variable, value from mst_environment where variable = 'AUTO_SHIPTO'"];
    while([results next]) {
        
        [data setObject: [results stringForColumn:@"value"] forKey:@"AutoShipTo"];
        
    }
    

    
    
    [database close];              
    
    
    // write config file back 
    [data writeToFile: configFinalPath atomically:YES];
    [data release];
    [docsPath release];
    
    
    
    // [configFinalPath release];
    
}

@end