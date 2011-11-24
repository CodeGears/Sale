//
//  CustomerDataHandler.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/21/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//
#define temp @""
#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Customer.h"
#import "CustomerChild.h"
#import "MJUtility.h"

@interface CustomerDataHandler : NSObject


- (NSMutableArray*)getAllCustomerType;
- (NSMutableArray*)getCustometListByType:(NSString*) type;
- (Customer*)getCustomerDetailbyProfileCode:(NSString*) profileCode;
- (NSMutableArray*) getAllCustomerChildren: (NSString*) profileCode;
- (NSMutableArray*) getAllHobbies: (NSString*) profileCode;
- (NSMutableArray*) getAllMembers: (NSString*) profileCode;
- (NSMutableArray*) getAllWorkPlaces: (NSString*) profileCode;
- (NSMutableArray*) getAllPatientType: (NSString*) profileCode;
- (CustomerStatus*) getAllProductRecommendation: (NSString*) profileCode;


//- (NSString*)getDBPath;
//- (Customer*)getCustometListByType:(NSString*) type;
//- ()getCustomerListByType: (NSString* )

// get all customer workplace return in form of Array of CustomerWorkPlace

@end
