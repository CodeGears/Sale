//
//  CustomerDataManager.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomerDataManager : NSObject {
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


+ (CustomerDataManager*)sharedInstance;

// Customer name list
- (NSArray*) GetCustomerNameKeys;
- (NSArray*) GetCustomerNameList;

- (NSArray*) GetCustomerType;

//Customer Detail Tab
- (NSString*) GetPictureProfilePath;
- (NSString*) GetCustomerDetailName;
- (NSString*) GetCustomerWorkName;

- (NSArray*) GetCustomerDetailSystemInfo;
- (NSArray*) GetCustomerDetailPersonalInfo;
- (NSArray*) GetCustomerDetailLocation;
- (NSArray*) GetCustomerDetailEducationInfo;
- (NSArray*) GetCustomerDetailFamilyInfo;
- (NSInteger) GetCustomerDetailChildCount;
- (NSArray*) GetCustomerDetailChildInfo;
- (NSInteger) GetCustomerDetailHobbyInfoCount;
- (NSArray*) GetCustomerDetailHobbyInfo;
- (NSInteger) GetCustomerDetailMemberDetailCount;
- (NSArray*) GetCustomerDetailMemberDetail;
- (NSArray*) GetCustomerDetailHomeInfo;
- (NSArray*) GetCustomerDetailClinicInfo;
- (NSInteger) GetCustomerDetailWorkplaceDetailCount;
- (NSArray*) GetCustomerDetailWorkplaceDetail;
- (NSArray*) GetCustomerDetailBussinessDetail;
- (NSArray*) GetCustomerDetailCustomerPatient;
- (NSArray*) GetCustomerDetailProductRecommend;
- (NSArray*) GetCustomerDetailStatus;
- (NSArray*) GetCustomerDetailSES;

- (NSArray*) GetCustomerDetailEditChildInfo:(NSString*)childID;
- (bool) SaveEditingChildInfo:(NSString*)childID Name:(NSString*)childname Sex:(NSString*)sex BirthDay:(NSString*)bd;
- (bool) AddNewChildInfo:(NSString*)childID Name:(NSString*)childname Sex:(NSString*)sex BirthDay:(NSString*)bd;

- (NSArray*) GetCustomerDetailEditHobbyInfo:(NSString*)hobbyID;
- (bool) SaveEditingHobbyInfo:(NSString*)hobbyID Type:(NSString*)hobbyType Description:(NSString*)desc;
- (bool) AddNewHobbyInfo:(NSString*)hobbyID Type:(NSString*)hobbyType Description:(NSString*)desc;
- (NSArray*) GetHobbyList;

- (NSArray*) GetCustomerDetailEditWorkplaceDetail:(NSString*)workplaceID;
- (bool) SaveEditingWorkplaceDetail:(NSString*)workplaceID Hospital:(NSString*)hospitalName Department:(NSString*)DepartName Building:(NSString*)buildingName WorkTime:(NSString*)worktime;
- (bool) AddNewWorkplaceDetail:(NSString*)workplaceID Hospital:(NSString*)hospitalName Department:(NSString*)DepartName Building:(NSString*)buildingName WorkTime:(NSString*)worktime;
@end
