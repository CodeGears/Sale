//
//  SalesHistory.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/26/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "SalesHistory.h"

@implementation SalesHistory
@synthesize number;
@synthesize date;
@synthesize product;
@synthesize quantity;
@synthesize unitPrice;
@synthesize free;
@synthesize amount;
@synthesize reason;

- (void)dealloc {
    
    [number release];
    [date release];
    [product release];
    [quantity release];
    [unitPrice release];
    [free release];
    [amount release];
    [reason release];
    [super dealloc];
}

@end
