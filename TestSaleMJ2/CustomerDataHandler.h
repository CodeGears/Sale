//
//  CustomerDataHandler.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/21/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Customer.h"
#import "CustomerChild.h"
#import "MJUtility.h"
#import "CustomerStatus.h"

@interface CustomerDataHandler : NSObject
+ (CustomerDataHandler*)sharedInstance;
// Customer detail View
- (NSMutableArray*)getAllCustomerType;

// return in form of Array of CustomerList object
- (NSMutableArray*)getCustometListByType:(NSString*) type;

// return in form of Customer Object
- (Customer*)getCustomerDetailbyProfileCode:(NSString*) profileCode;

// return in form of Array of CustomerChild Object
- (NSMutableArray*) getAllCustomerChildren: (NSString*) profileCode;

// return in form of Array of Hobby
- (NSMutableArray*) getAllHobbies: (NSString*) profileCode;

// return in form of Array of CustomerMember
- (NSMutableArray*) getAllMembers: (NSString*) profileCode;

// return in form of Array of CustomerWorkPlace
- (NSMutableArray*) getAllWorkPlaces: (NSString*) profileCode;

// intrnal functions
- (NSMutableArray*) getAllPatientTypeLabel;

// return in form of Array of CustomerPatient
- (NSMutableArray*) getAllPatientType:(NSString*) profileCode;

// return in form of Array of CustomerStatus
- (CustomerStatus*) getAllStatus: (NSString*) profileCode;

// internal functions
- (NSMutableArray*) getAllProductBrandLabel;

// return in form of Array of CustomerProduct 
- (NSMutableArray*) getAllProductBrand:(NSString*) profileCode;

// picklist Value
- (NSMutableArray*) getAllPickListTitleName;
- (NSMutableArray*) getAllPickListRoleName;
- (NSMutableArray*) getAllPickListEduLevelName;
- (NSMutableArray*) getAllPickListEduMajorName;
- (NSMutableArray*) getAllPickListEduPlaceName;
- (NSMutableArray*) getAllPickListMaritialStatName;
- (NSMutableArray*) getAllPickListHHIncomeName;
- (NSMutableArray*) getAllPickListProvince;
- (NSMutableArray*) getAllPickListSex;
- (NSMutableArray*) getAllPickListHobbies;
- (NSMutableArray*) getAllPickListHospital;
- (NSMutableArray*) getAllPickListDepartment;

// Call history and Sales History
-(NSMutableArray*) getAllCallHistory: (NSString* )profileCode;

// return in form of Array of CallHistory
-(NSMutableArray*) getAllSalesHistoryInvoice: (NSString* )custCode1 and: (NSString* )custCode2  and:(NSString* )custCode3;

// return in form of Array of SalesHistory
-(NSMutableArray*) getAllSalesHistoryBackOrder: (NSString* )custCode1 and: (NSString* )custCode2  and:(NSString* )custCode3;


-(BOOL) updateCustomerDetail:(Customer*) customer;
//-(BOOL) updateCustomerGPS:(NSString*) profileCode withLat: (NSString*) latitute withLong:(NSString*) longtitute ;
@end
