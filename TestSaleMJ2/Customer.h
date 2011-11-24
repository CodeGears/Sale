//
//  Customer.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/22/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Customer : NSObject{
    
   
    
    NSData* pic;
    NSString* titleName;
    NSString* firstName;
    NSString* lastName;
    NSString* role;

    NSString* profileCode;
    NSString* customerCode1;
    NSString* customerCode2;
    NSString* customerCode3;
    NSString* email;
    NSString* telephone;
    NSString* sex;
    NSDate* birthDay;
    NSString* idNumber;
    NSString* latitude;
    NSString* longtitude;
    NSDate* gpsupdateDate;
    NSString* educationLevel;
    NSString* educationMajor;
    NSString* educationPlace;
    NSString* maritialStat;
    NSString* spouseTitleName;
    NSString* spouseFirstName;
    NSString* spouseLastName;
    
    NSDate* spousebirthdate;
    //NSString* numberOfChild;

    NSString* hhIncome;
    
    // home section
    NSString* homeAddress1;
    NSString* homeAddress2;
    NSString* homeSubDistrict;
    NSString* homeDistrict;
    NSString* homeProvince;
    NSString* homeZip;
    NSString* homePhone;
    NSString* homeExt;
    NSString* homefax;
    NSString* homeConvenienceTime;
    
    //clinic section
    
    
    NSString* clinicAddress1;
    NSString* clinicAddress2;
    NSString* clinicSubDistrict;
    NSString* clinicDistrict;
    NSString* clinicProvince;
    NSString* clinicZip;
    NSString* clinicPhone;
    NSString* clinicExt;
    NSString* clinicfax;
    NSString* clinicConvenienceTime;
    
    // Business
    BOOL emerald;
    BOOL sapphire;
    // SES
    BOOL high;
    BOOL medium;
    BOOL low;
    
    // EDC
    NSDate *EDC;
}


@property(retain, nonatomic)NSData *pic;
@property(retain, nonatomic)NSString *titleName;
@property(retain, nonatomic)NSString *firstName;
@property(retain, nonatomic)NSString *lastName;
@property(retain, nonatomic)NSString *role;

@property(nonatomic, retain) NSString *profileCode;
@property(nonatomic,retain) NSString *customerCode1;
@property(nonatomic,retain) NSString *customerCode2;
@property(nonatomic,retain) NSString *customerCode3;
@property(retain, nonatomic) NSString *email;

@property(retain, nonatomic)NSString *telephone;
@property(retain, nonatomic)NSString *sex;
@property(retain, nonatomic)NSDate *birthDay;
@property(retain, nonatomic)NSString *idNumber;
@property(retain, nonatomic)NSString *latitude;

@property(retain, nonatomic)NSString *longtitude;
@property(retain, nonatomic)NSDate *gpsupdateDate;
@property(retain, nonatomic)NSString *educationLevel;
@property(retain, nonatomic)NSString *educationMajor;
@property(retain, nonatomic)NSString *educationPlace;

@property(retain, nonatomic)NSString *maritialStat;

@property(retain, nonatomic)NSString* spouseTitleName;
@property(retain, nonatomic)NSString* spouseFirstName;
@property(retain, nonatomic)NSString* spouseLastName;
@property(retain, nonatomic)NSDate *spousebirthdate;
//NSString* numberOfChild;

@property(retain, nonatomic)NSString *hhIncome;

// home section
@property(retain, nonatomic) NSString *homeAddress1;
@property(retain, nonatomic)NSString *homeAddress2;
@property(retain, nonatomic)NSString *homeSubDistrict;
@property(retain, nonatomic)NSString *homeDistrict;
@property(retain, nonatomic)NSString *homeProvince;
@property(retain, nonatomic)NSString *homeZip;
@property(retain, nonatomic)NSString *homePhone;
@property(retain, nonatomic)NSString *homeExt;
@property(retain, nonatomic)NSString *homefax;
@property(retain, nonatomic)NSString *homeConvenienceTime;

//clinic section

@property(retain, nonatomic)NSString *clinicAddress1;
@property(retain, nonatomic)NSString *clinicAddress2;
@property(retain, nonatomic)NSString *clinicSubDistrict;
@property(retain, nonatomic)NSString *clinicDistrict;
@property(retain, nonatomic)NSString *clinicProvince;
@property(retain, nonatomic)NSString *clinicZip;
@property(retain, nonatomic)NSString *clinicPhone;
@property(retain, nonatomic)NSString *clinicExt;
@property(retain, nonatomic)NSString *clinicfax;
@property(retain, nonatomic)NSString *clinicConvenienceTime;

// Business
@property(nonatomic) BOOL emerald;
@property(nonatomic) BOOL sapphire;
// SES
@property(nonatomic) BOOL high;
@property(nonatomic) BOOL medium;
@property(nonatomic) BOOL low;
//EDC
@property(nonatomic,retain) NSDate *EDC;

@end
