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

// for supporting saving transactin to txn_list 
-(BOOL) checkInTxn: (NSString*) txn_no type: (NSString*) type{
    FMDatabase *database = [FMDatabase databaseWithPath: [self getDBPath]]; 
    
    [database open];
    txn_no = [txn_no stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int result = [database intForQuery: [NSString stringWithFormat: @"SELECT COUNT(Txn_no) FROM txn_list WHERE TRIM(Txn_no) = '%@' AND Type = '%@' AND Txn_status = 'P' ",txn_no,type]];
    if (result == 0){
       
        // create new record 
        [database close];
        return [self newTxn:txn_no type:type profileCode:txn_no customerCode:nil appStatus: @"WT"] ; 
    
    }else{
        //update old record 
        
        BOOL boolean1 = [database executeUpdate:@"update txn_list SET txn_date = CURRENT_TIMESTAMP WHERE txn_no = ? AND txn_status = 'P' ",txn_no];
        
        [database close];
        return boolean1;
    }
        
}
// for creating new transaction record to txn_list 
-(BOOL) newTxn: (NSString*) txn_no type: (NSString*) type profileCode:(NSString*) profileCode customerCode: (NSString*) customerCode appStatus: (NSString*) appStatus{
    
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
   
    //get max docnum 
    int doc_num =[database intForQuery:@"SELECT MAX(doc_num) FROM txn_list"]+1;
    NSString *max = [NSString stringWithFormat:@"%d",doc_num] ;
    //NSString *max = [database stringForQuery:@"SELECT MAX(doc_num) FROM txn_list"];


        BOOL boolean1 = [database executeUpdate:@"INSERT INTO txn_list(doc_num,txn_no,type,txn_date,txn_status,app_status,Prof_Code,customer_code,is_active)VALUES (?,?,?,CURRENT_TIMESTAMP,'P',?,?,?,'Y')",max,txn_no,type,appStatus,profileCode,customerCode];
        
        [database close];
        return boolean1;
    
    
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
        code = [code stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* result = [database stringForQuery:[NSString stringWithFormat: @"select %@ from %@ WHERE TRIM(%@) = '%@'", resCol, table, codeCol, code  ]];
       
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

- (NSString* )convertBooleanToY: (BOOL) boolean
{
    if(boolean)
    {
      return @"Y";
    }else return nil;
}
-(NSString*) getMJConfigInfo: (NSString*) key{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *configFinalPath = [docsPath stringByAppendingPathComponent: @"MJConfig.plist"]; 
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: configFinalPath ];
    return [data objectForKey:key];

}

-(int) findNewDocnumForTable: (NSString*) table{
    FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
    
    [database open];
    int doc_num = [database intForQuery:[NSString stringWithFormat: @"SELECT MAX(doc_num) FROM %@",table]]+1;
    [database close];
    return doc_num;
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