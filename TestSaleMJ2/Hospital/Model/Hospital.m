//
//  Hospital.m
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital

@synthesize hospitalCode        = _hospitalCode;
@synthesize firstCustomerCode   = _firstCustomerCode;
@synthesize secondCustomerCode  = _secondCustomerCode;
@synthesize thirdCustomerCode   = _thirdCustomerCode;

@synthesize hospitalName        = _hospitalName;
@synthesize address             = _address;
@synthesize subDistrict         = _subDistrict;
@synthesize district            = _district;
@synthesize province            = _province;
@synthesize zip                 = _zip;
@synthesize telephone           = _telephone;
@synthesize fax                 = _fax;

@synthesize hospitalType        = _hospitalType;
@synthesize totalBed            = _totalBed;
@synthesize obBed               = _obBed;
@synthesize pedBed              = _pedBed;
@synthesize opdDay              = _opdDay;
@synthesize ipdDay              = _ipdDay;
@synthesize hcpOb               = _hcpOb;
@synthesize hcpPed              = _hcpPed;
@synthesize average             = _average;
@synthesize activeOrder         = _activeOrder;
@synthesize note                = _note;
@synthesize deliveryFeeNormal   = _deliveryFeeNormal;
@synthesize deliveryFeeCassarian = _deliveryFeeCaesarian;
@synthesize latitude            = _latitude;
@synthesize longtitude          = _longtitude;

- (id)init
{
    if(self = [super init]) {
        _hospitalCode       = [[NSString stringWithFormat:@"Sample Hospital Code"] retain];
        _firstCustomerCode  = [[NSString stringWithFormat:@"First Customer Code"] retain];
        _secondCustomerCode = [[NSString stringWithFormat:@"Second Customer Code"] retain];
        _thirdCustomerCode  = [[NSString stringWithFormat:@"Third Customer Code"] retain];
        
        _hospitalName       = [[NSString stringWithFormat:@"Sample Hospital Name"] retain];
        _address            = [[NSString stringWithFormat:@"Address"] retain];
        _subDistrict        = [[NSString stringWithFormat:@"Sample Sub-District"] retain];
        _district           = [[NSString stringWithFormat:@"District"] retain];
        _province           = [[NSString stringWithFormat:@"Province"] retain];
        _zip                = [[NSString stringWithFormat:@"Zip"] retain];
        _telephone          = [[NSString stringWithFormat:@"Telephone"] retain];
        _fax                = [[NSString stringWithFormat:@"Fax"] retain];
        
        _hospitalType       = [[NSString stringWithFormat:@"Sample Hospital Type"] retain];
        _totalBed           = [[NSString stringWithFormat:@"Total Bed"] retain];
        _obBed              = [[NSString stringWithFormat:@"OB Bed"] retain];
        _pedBed             = [[NSString stringWithFormat:@"Ped Bed"] retain];
        _opdDay             = [[NSString stringWithFormat:@"Opd Day"] retain];
        _ipdDay             = [[NSString stringWithFormat:@"Ipd Day"] retain];
        _hcpOb              = [[NSString stringWithFormat:@"Hcp Ob"] retain];
        _hcpPed             = [[NSString stringWithFormat:@"Total Bed"] retain];
        _average            = [[NSString stringWithFormat:@"Average"] retain];
        _note               = [[NSString stringWithFormat:@"Note"] retain];
        _deliveryFeeNormal  = [[NSString stringWithFormat:@"Deleivery Fee"] retain];
        _deliveryFeeCaesarian = [[NSString stringWithFormat:@"Deleivery Fee Caesarian"] retain];
        _activeOrder        = [[NSString stringWithFormat:@"Active Order"] retain];
        _latitude           = [[NSString stringWithFormat:@"Latitude"] retain];
        _longtitude         = [[NSString stringWithFormat:@"Longtitude"] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_hospitalCode release];
    [_firstCustomerCode release];
    [_secondCustomerCode release];
    [_thirdCustomerCode release];
    
    [_hospitalName release];
    [_address release];
    [_subDistrict release];
    [_district release];
    [_province release];
    [_zip release];
    [_telephone release];
    [_fax release];
    
    [_hospitalType release];
    [_totalBed release];
    [_obBed release];
    [_pedBed release];
    [_opdDay release];
    [_ipdDay release];
    [_hcpOb release];
    [_hcpPed release];
    [_average release];
    [_note release];
    [_deliveryFeeNormal release];
    [_deliveryFeeCaesarian release];
    [_activeOrder release];
    [_latitude release];
    [_longtitude release];
    
    [super dealloc];
}

- (NSString *)getBedInfo
{
    return [NSString stringWithFormat:@"OB: %@ \t\t PED: %@ \t\t OPD: %@ \t\t IPD: %@", _obBed, _pedBed, _opdDay, _ipdDay];
}

- (NSString *)getHCPInfo
{
    return [NSString stringWithFormat:@"OB: %@ \t\t PED: %@ \t\t Avg. Btw/Mth: %@", _hcpOb, _hcpPed, _average];
}

@end
