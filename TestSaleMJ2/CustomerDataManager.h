//
//  CustomerDataManager.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface ContactProfile : NSObject {
    NSString* profileCode;
    NSString* name;
    NSString* group;
    BOOL      isActive;  
}

@property (retain, nonatomic) NSString* profileCode;
@property (retain, nonatomic) NSString* name;
@property (retain, nonatomic) NSString* group;
@property (readwrite, nonatomic) BOOL isActive;


@end

@interface CustomerDataManager : NSObject {
    
    
    
    
    //Database
    sqlite3* contactDB;
    NSString* databasePath_contactDB;
    
    //Local variable
    
    NSString* curSelectProfileCode;
    
    NSArray* nameKeys;
    NSArray* nameList;
    
    NSArray* customerType;
    
    NSString* customerName;
    NSString* customerWorkName;
    
    NSArray* systemInfo;
    NSArray* personalInfo;
    NSArray* locationInfo;
    NSArray* educationInfo;
    NSArray* familyInfo;
    NSMutableArray* childInfo;
    NSMutableArray* hobbyInfo;
    NSMutableArray* memberInfo;
    NSArray* homeInfo;
    NSArray* clinicInfo;
    NSMutableArray* workplaceDetail;
    NSArray* bussinessDetail;
    NSArray* customerPatient;
    NSArray* productRecommend;
    NSArray* status;
    NSArray* ses;
   // Customer* customer;
}

@property (retain,nonatomic) NSArray* nameKeys;
@property (retain,nonatomic) NSArray* nameList;

@property (retain,nonatomic) NSArray* customerType;

@property (retain,nonatomic) NSString* customerName;
@property (retain,nonatomic) NSString* customerWorkName;

@property (retain,nonatomic) NSArray* systemInfo;
@property (retain,nonatomic) NSArray* personalInfo;
@property (retain,nonatomic) NSArray* locationInfo;
@property (retain,nonatomic) NSArray* educationInfo;
@property (retain,nonatomic) NSArray* familyInfo;
@property (retain,nonatomic) NSMutableArray* childInfo;
@property (retain,nonatomic) NSMutableArray* hobbyInfo;
@property (retain,nonatomic) NSMutableArray* memberInfo;
@property (retain,nonatomic) NSArray* homeInfo;
@property (retain,nonatomic) NSArray* clinicInfo;
@property (retain,nonatomic) NSMutableArray* workplaceDetail;
@property (retain,nonatomic) NSArray* bussinessDetail;
@property (retain,nonatomic) NSArray* customerPatient;
@property (retain,nonatomic) NSArray* productRecommend;
@property (retain,nonatomic) NSArray* status;
@property (retain,nonatomic) NSArray* ses;
//@property (retain, nonatomic) Customer* customer;


+ (CustomerDataManager*)sharedInstance;

// Customer name list
//Use to get section header in customer name contact table
- (NSArray*) GetCustomerNameKeys;

//Use to get customer name in contact table
- (NSArray*) GetCustomerNameList:(NSString*)type;

- (NSArray*) GetCustomerType;

//Customer Detail Tab
- (NSString*) GetPictureProfilePath:(NSString*)profileCode;
- (NSString*) GetCustomerDetailName:(NSString*)profileCode;
- (NSString*) GetCustomerWorkName:(NSString*)profileCode;

- (NSArray*) GetCustomerDetailSystemInfo:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailPersonalInfo:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailLocation:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailEducationInfo:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailFamilyInfo:(NSString*)profileCode;
- (NSInteger) GetCustomerDetailChildCount:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailChildInfo:(NSString*)profileCode;
- (NSInteger) GetCustomerDetailHobbyInfoCount:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailHobbyInfo:(NSString*)profileCode;
- (NSInteger) GetCustomerDetailMemberDetailCount:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailMemberDetail:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailHomeInfo:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailClinicInfo:(NSString*)profileCode;
- (NSInteger) GetCustomerDetailWorkplaceDetailCount:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailWorkplaceDetail:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailBussinessDetail:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailCustomerPatient:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailProductRecommend:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailStatus:(NSString*)profileCode;
- (NSArray*) GetCustomerDetailSES:(NSString*)profileCode;

- (NSArray*) GetCustomerDetailEditChildInfo:(NSString*)profileCode WithChild:(NSString*)childID;

- (bool) SaveEditingChildInfo:(NSString*)profileCode withChild:(NSString*)childID Name:(NSString*)childname Sex:(NSString*)sex BirthDay:(NSString*)bd;

- (bool) AddNewChildInfo:(NSString*)profileCode withChild:(NSString*)childID Name:(NSString*)childname Sex:(NSString*)sex BirthDay:(NSString*)bd;

- (NSArray*) GetCustomerDetailEditHobbyInfo:(NSString*)profileCode withHobby:(NSString*)hobbyID;

- (bool) SaveEditingHobbyInfo:(NSString*)profileCode withHobby:(NSString*)hobbyID Type:(NSString*)hobbyType Description:(NSString*)desc;

- (bool) AddNewHobbyInfo:(NSString*)profileCode withHobby:(NSString*)hobbyID Type:(NSString*)hobbyType Description:(NSString*)desc;

- (NSArray*) GetHobbyList;

- (NSArray*) GetCustomerDetailEditWorkplaceDetail:(NSString*)profileCode withWorkplace:(NSString*)workplaceID;

- (bool) SaveEditingWorkplaceDetail:(NSString*)profileCode withWorkplace:(NSString*)workplaceID Hospital:(NSString*)hospitalName Department:(NSString*)DepartName Building:(NSString*)buildingName WorkTime:(NSString*)worktime;

- (bool) AddNewWorkplaceDetail:(NSString*)profileCode withWorkplace:(NSString*)workplaceID Hospital:(NSString*)hospitalName Department:(NSString*)DepartName Building:(NSString*)buildingName WorkTime:(NSString*)worktime;
@end
