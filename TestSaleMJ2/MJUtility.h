//
//  MJUtility.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/21/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJUtility : NSObject

+ (MJUtility*)sharedInstance;
- (NSString*)getDBPath;
-(NSDate*) convertStringDateToNSDate: (NSString*)stringDate;
-(NSString*)convertNSDateToString: (NSDate*) date;
- (UIImage*)convertNSDataToUIImage: (NSData*) data;
- (NSString* )convertBooleanToY: (BOOL) boolean;
-(void) initializeDB;
-(NSString*) getMJConfigInfo: (NSString*) key;
-(NSString*) getPicklistValueFromTable: (NSString*) table resultColumn: (NSString*) resCol codeColumn:(NSString*) codeCol code: (NSString*) code; 
@end
