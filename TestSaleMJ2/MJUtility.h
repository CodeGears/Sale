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
-(BOOL) checkInTxn: (NSString*) txn_no type: (NSString*) type;
// for creating new transaction record to txn_list 
-(BOOL) newTxn: (NSString*) txn_no type: (NSString*) type profileCode:(NSString*) profileCode customerCode: (NSString*) customerCode appStatus: (NSString*) appStatus;
-(NSDate*) convertStringDateToNSDate: (NSString*)stringDate;
-(NSString*)convertNSDateToString: (NSDate*) date;
- (UIImage*)convertNSDataToUIImage: (NSData*) data;
- (NSString* )convertBooleanToY: (BOOL) boolean;
-(void) initializeDB;
-(NSString*) getMJConfigInfo: (NSString*) key;
-(NSString*) getPicklistValueFromTable: (NSString*) table resultColumn: (NSString*) resCol codeColumn:(NSString*) codeCol code: (NSString*) code; 
-(int) findNewDocnumForTable: (NSString*) table;

-(NSString*) generateVisitDocNumberbyVisitType:(NSString*) type; 
-  (NSString*) convertMonthToABCFormat: (NSInteger) month;
@end
