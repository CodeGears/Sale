//
//  Invoice.m
//  Sale
//
//  Created by iterate on 11/23/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "Invoice.h"

@implementation Invoice

@synthesize date      = _date;
@synthesize invoiceId = _invoiceId;
@synthesize product   = _product;
@synthesize quantity  = _quantity;
@synthesize free      = _free;
@synthesize amount    = _amount;


+ (NSMutableArray *)getInvoicesForHospitalId:(NSString *)hospitalId
{
    
    return NULL;
}

- (id)init
{
    if(self = [super init]) {
        _date       = [[NSDate date] retain];
        _invoiceId  = [[NSString stringWithFormat:@"Invoid Id"] retain];
        _product    = [[NSString stringWithFormat:@"Sample Product"] retain];
        _quantity    = [[NSString stringWithFormat:@"100"] retain];
        _free       = [[NSString stringWithFormat:@"100"] retain];
        _amount     = [[NSString stringWithFormat:@"200000"] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_date release];
    [_invoiceId release];
    [_product release];
    [_quantity release];
    [_free release];
    [_amount release];
    
    [super dealloc];
}

@end
    