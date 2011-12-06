//
//  BackOrder.m
//  Sale
//
//  Created by iterate on 11/23/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "BackOrder.h"

@implementation BackOrder

@synthesize date     = _date;
@synthesize orderId  = _orderId;
@synthesize product  = _product;
@synthesize quantity = _quantity;
@synthesize free     = _free;
@synthesize amount   = _amount;
@synthesize reason   = _reason;

- (id)init
{
    if (self = [super init]) {
        _date     = [[NSDate date] retain];
        _orderId  = [[NSString stringWithFormat:@"Sample Order ID"] retain];
        _product  = [[NSString stringWithFormat:@"Sample Product"] retain];
        _quantity = [[NSString stringWithFormat:@"100"] retain];
        _free     = [[NSString stringWithFormat:@"100"] retain];
        _amount   = [[NSString stringWithFormat:@"200000"] retain];
        _reason   = [[NSString stringWithFormat:@"Out of Order"] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_date release];
    [_orderId release];
    [_product release];
    [_quantity release];
    [_free release];
    [_amount release];
    [_reason release];
    
    [super dealloc];
}


@end
