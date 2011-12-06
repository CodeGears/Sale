//
//  Order.m
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "Order.h"

@implementation Order

@synthesize customerCode = _customerCode;
@synthesize role         = _role;
@synthesize address      = _address;
@synthesize hospital     = _hospital;
@synthesize category     = _category;
@synthesize orderId      = _orderId;
@synthesize poId         = _poId;
@synthesize saleQuality  = _saleQuality;
@synthesize focQuality   = _focQuality;
@synthesize spdQuality   = _spdQuality;
@synthesize totalAmount  = _totalAmount;
@synthesize firstRemark  = _firstRemark;
@synthesize secondRemark = _secondRemark;

@synthesize billTo       = _billTo;
@synthesize shipTo       = _shipTo;

- (id)init
{
    if(self = [super init]) {
        
        _customerCode = [[NSString stringWithFormat:@"Sample Code"] retain];
        _role         = [[NSString stringWithFormat:@"Sample Role"] retain];
        _address      = [[NSString stringWithFormat:@"Sample Address"] retain];
        _hospital     = [[NSString stringWithFormat:@"Sample Hospital"] retain];
        _category     = [[NSString stringWithFormat:@"Sample Category"] retain];
        _orderId      = [[NSString stringWithFormat:@"Sample Order ID"] retain];
        _poId         = [[NSString stringWithFormat:@"Sample PoId"] retain];
        _saleQuality  = [[NSString stringWithFormat:@"Sample Sale Quality"] retain];
        _focQuality   = [[NSString stringWithFormat:@"Sample Foc Qualtiy"] retain];
        _spdQuality   = [[NSString stringWithFormat:@"Sample Spd Quality"] retain];
        _totalAmount  = [[NSString stringWithFormat:@"Sample Total Amount"] retain];
        _firstRemark  = [[NSString stringWithFormat:@"Sample First Remark"] retain];
        _secondRemark = [[NSString stringWithFormat:@"Sample Second Remark"] retain];
        
        _billTo       = [[NSString stringWithFormat:@"Sample Bill TO"] retain];
        _shipTo       = [[NSString stringWithFormat:@"Sample Ship TO"] retain];
        
    }
    
    return self;
}

- (void)dealloc
{
    [_customerCode release];
    [_role release];
    [_address release];
    [_hospital release];
    [_category release];
    [_orderId release];
    [_poId release];
    [_saleQuality release];
    [_focQuality release];
    [_spdQuality release];
    [_totalAmount release];
    [_firstRemark release];
    [_secondRemark release];
    
    [_billTo release];
    [_shipTo  release];
    
    [super dealloc];
}

@end
