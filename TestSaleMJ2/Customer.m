//
//  Customer.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/22/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "Customer.h"

@implementation Customer

 
 @synthesize pic;
 @synthesize titleName;
 @synthesize firstName;
 @synthesize lastName;
@synthesize role;
 @synthesize  profileCode;
 @synthesize  customerCode1;
 @synthesize  customerCode2;
 @synthesize  customerCode3;
 @synthesize email;
 @synthesize telephone;
 @synthesize sex;
 @synthesize  birthDay;
 @synthesize idNumber;
 @synthesize latitude;
 @synthesize longtitude;
 @synthesize  gpsupdateDate;
 @synthesize educationLevel;
 @synthesize educationMajor;
 @synthesize educationPlace;
 @synthesize maritialStat;
@synthesize spouseTitleName;
@synthesize spouseFirstName;
@synthesize spouseLastName;
 @synthesize  spousebirthdate;
// @synthesize numberOfChild;

 @synthesize hhIncome;

// home section
 @synthesize homeAddress1;
 @synthesize homeAddress2;
 @synthesize homeSubDistrict;
 @synthesize homeDistrict;
 @synthesize homeProvince;
 @synthesize homeZip;
 @synthesize homePhone;
 @synthesize homeExt;
 @synthesize homefax;
 @synthesize homeConvenienceTime;

//clinic section


 @synthesize clinicAddress1;
 @synthesize clinicAddress2;
 @synthesize clinicSubDistrict;
 @synthesize clinicDistrict;
 @synthesize clinicProvince;
 @synthesize clinicZip;
 @synthesize clinicPhone;
 @synthesize clinicExt;
 @synthesize clinicfax;
 @synthesize clinicConvenienceTime;

@synthesize emerald;
@synthesize sapphire;
@synthesize high;
@synthesize medium;
@synthesize low;

@synthesize EDC;

- (void)dealloc
{
    [pic release];
    [titleName release];
    [firstName release];
    [lastName release];
    [role release];
    [ profileCode release];
    [ customerCode1 release];
    [ customerCode2 release];
    [ customerCode3 release];
    [email release];
    [telephone release];
    [sex release];
    [ birthDay release];
    [idNumber release];
    [latitude release];
    [longtitude release];
    [ gpsupdateDate release];
    [educationLevel release];
    [educationMajor release];
    [educationPlace release];
    [maritialStat release];
    [spouseTitleName release];
    [spouseFirstName release];
    [spouseLastName release];
    [ spousebirthdate release];
    // [numberOfChild;
    
    [hhIncome release];
    
    // home section
    [homeAddress1 release];
    [homeAddress2 release];
    [homeSubDistrict release];
    [homeDistrict release];
    [homeProvince release];
    [homeZip release];
    [homePhone release];
    [homeExt release];
    [homefax release]; 
    [homeConvenienceTime release];
    
    //clinic section
    
    
    [clinicAddress1 release];
    [clinicAddress2 release];
    [clinicSubDistrict release];
    [clinicDistrict release];
    [clinicProvince release];
    [clinicZip release];
    [clinicPhone release];
    [clinicExt release];
    [clinicfax release];
    [clinicConvenienceTime release];
    
    [EDC release];
    [super dealloc];
    
}

@end
