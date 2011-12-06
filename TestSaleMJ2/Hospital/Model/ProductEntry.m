//
//  ProductEntry.m
//  Sale
//
//  Created by iterate on 12/5/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "ProductEntry.h"

@implementation ProductEntry

@synthesize entryId     = _entryId;
@synthesize productCode = _productCode;
@synthesize productName = _productName;
@synthesize quantity    = _quantity;
@synthesize foc         = _foc;
@synthesize unit        = _unit;
@synthesize price       = _price;
@synthesize amount      = _amount;
@synthesize stock       = _stock;

- (id)init
{
    if (self = [super init]) {
        
        _entryId = [[NSString stringWithFormat:@"Sample ID"] retain];
        _productCode = [[NSString stringWithFormat:@"Sample Code"] retain];
        _productName = [[NSString stringWithFormat:@"Product Name"] retain];
        _quantity    = [[NSString stringWithFormat:@"Sample Quantity"] retain];
        _foc         = [[NSString stringWithFormat:@"FOC"] retain];
        _unit        = [[NSString stringWithFormat:@"Unit"] retain];
        _price       = [[NSString stringWithFormat:@"price"] retain];
        _amount      = [[NSString stringWithFormat:@"Amount"] retain];
        
        _stock       = [[NSString stringWithFormat:@"Stock"] retain];
        
    }
    return self;
}

- (void)dealloc
{
    [_entryId release];
    [_productCode release];
    [_productName release];
    [_quantity release];
    [_foc release];
    [_unit release];
    [_price release];
    [_amount release];

    [_stock release];
    
    [super dealloc];
}

@end
