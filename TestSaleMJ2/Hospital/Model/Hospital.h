//
//  Hospital.h
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hospital : NSObject
{
    NSString *_hospitalCode;
    NSString *_firstCustomerCode;
    NSString *_secondCustomerCode;
    NSString *_hospitalName;

    NSString *_address;
    NSString *_subDistrict;
    NSString *_district;
    NSString *_province;
    NSString *_zip;
    NSString *_telephone;
    NSString *_fax;

    NSString *_hospitalType;
    NSString *_totalBed;    
    NSString *_obBed;
    NSString *_pedBed;
    NSString *_opdDay;
    NSString *_ipdDay;
    NSString *_hcpOb;
    NSString *_hcpPed;
    NSString *_average;
    NSString *_note;
    NSString *_deliveryFeeNormal;
    NSString *_deliveryFeeCaesarian;
    NSString *_latitude;
    NSString *_longtitude;
    
    NSString *_activeOrder;
    
}

@property (nonatomic, retain) NSString *hospitalCode;
@property (nonatomic, retain) NSString *firstCustomerCode;
@property (nonatomic, retain) NSString *secondCustomerCode;
@property (nonatomic, retain) NSString *thirdCustomerCode;
@property (nonatomic, retain) NSString *hospitalName;

@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *subDistrict;
@property (nonatomic, retain) NSString *district;
@property (nonatomic, retain) NSString *province;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *telephone;
@property (nonatomic, retain) NSString *fax;

@property (nonatomic, retain) NSString *hospitalType;
@property (nonatomic, retain) NSString *totalBed;
@property (nonatomic, retain) NSString *obBed;
@property (nonatomic, retain) NSString *pedBed;
@property (nonatomic, retain) NSString *opdDay;
@property (nonatomic, retain) NSString *ipdDay;
@property (nonatomic, retain) NSString *hcpOb;
@property (nonatomic, retain) NSString *hcpPed;
@property (nonatomic, retain) NSString *average;
@property (nonatomic, retain) NSString *note;
@property (nonatomic, retain) NSString *deliveryFeeNormal;
@property (nonatomic, retain) NSString *deliveryFeeCassarian;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longtitude;

@property (nonatomic, retain) NSString *activeOrder;

- (NSString *)getBedInfo;
- (NSString *)getHCPInfo;

@end
