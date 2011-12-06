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
@class CustomerChild;
@class Hobby;
@class CustomerWorkPlace;
@class CustomerPatient;
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

// picklist Value for using when editing 
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

// **this will return the rest of hospital that not hae in workplace list
- (NSMutableArray*) getAllPickListHospitalfor:(NSString*) profileCode;
- (NSMutableArray*) getAllPickListDepartment;

// Call history and Sales History
-(NSMutableArray*) getAllCallHistory: (NSString* )profileCode;

// return in form of Array of CallHistory
-(NSMutableArray*) getAllSalesHistoryInvoice: (NSString* )custCode1 and: (NSString* )custCode2  and:(NSString* )custCode3;

// return in form of Array of SalesHistory
-(NSMutableArray*) getAllSalesHistoryBackOrder: (NSString* )custCode1 and: (NSString* )custCode2  and:(NSString* )custCode3;

///***************************** UPDATE *********************************

//Customer Detail

// Return in form of NSMutableDictionary key(Status,ErrorMsg) Value(NSString,NSString)
//Status @"Y" or  @"N"
// return False if have a problem to insert to database
-(NSMutableDictionary*) updateCustomerDetail:(Customer*) customer;

// new customer 
-(NSMutableDictionary*) newCustomerDetail:(Customer*) customer;

// return nil if cannot insert to table , if succeed return last updated date
-(NSDate*) updateCustomerGPSProfileCode:(NSString*) profileCode withLat: (NSString*) latitute withLong:(NSString*) longtitute;
//Customer Child

- (NSMutableDictionary*) updateCustomerChild: (CustomerChild*) child withProfileCode: (NSString*) profileCode;

- (NSMutableDictionary*) deleteCustomerChildByChildNumber: (NSString*) childNumber withProfileCode: (NSString*) profileCode;

// new customer child 
- (NSMutableDictionary*) newCustomerChild: (CustomerChild*) child withProfileCode: (NSString*) profileCode;

// Customer Hobbies
- (NSMutableDictionary*) updateCustomerHobby: (Hobby*) hobby withProfileCode: (NSString*) profileCode;

- (NSMutableDictionary*) deleteCustomerHobbyByHobbyName: (NSString*) hobbyName withProfileCode: (NSString*) profileCode;

- ( NSMutableDictionary*) newCustomerHobby: (Hobby*) hobby withProfileCode: (NSString*) profileCode;

// update customer workplace // cannot update hospital name
- (NSMutableDictionary*) updateCustomerWorkPlace: (CustomerWorkPlace*) wp withProfileCode: (NSString*) profileCode;

// update customer workplace // cannot update hospital name
- (NSMutableDictionary*) newCustomerWorkPlace: (CustomerWorkPlace*) wp withProfileCode: (NSString*) profileCode;

// delete customer Workplace
- (NSMutableDictionary*) deleteCustomerWorkPlaceByHospitalName: (NSString*) hospitalName withProfileCode: (NSString*) profileCode;

//update customer patient ** recieve NSMutableArray of Customer Patients 
- (NSMutableDictionary*) updateCustomerPatientwith: (NSMutableArray*) cp withProfileCode:(NSString*) profileCode;

- (NSMutableDictionary*) updateCustomerStatus: (CustomerStatus*) customerStatus withProfileCode:(NSString*) profileCode;

//chweck validity of Patient and productrecommend
- (BOOL) checkValidityPatient: (NSMutableArray*) cpArray withProductRecommend: (NSMutableArray*) prArray;

//update customer patient ** recieve NSMutableArray of Customer Products
- (NSMutableDictionary*) updateCustomerProductwith: (NSMutableArray*) prArray withProfileCode:(NSString*) profileCode;

// *********************************Customer Visit ***************************
// return in form of Array of NSDate
-(NSMutableArray*) getDateForRecordCall; 

// return in form of NSString

-(NSMutableArray*) getCallObjectiveRecordCall;

// return in form of Array of string
-(NSMutableArray*) getCallProductRecordCall;

// return in form of Array of string
-(NSMutableArray*) getCallResultRecordCall;

// return in form of Array of string
-(NSMutableArray*) getCallComplaintRecordCall;

// return in form of Array of NSString
-(NSMutableArray*) getSupervisorRecordCall;


@end
