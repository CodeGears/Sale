//
//  CustomerProduct.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/24/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "CustomerProduct.h"

@implementation CustomerProduct

@synthesize name;
@synthesize code;
@synthesize recQty;

- (void)dealloc {
    [name release];
    [code release];
    [recQty release];
    [super dealloc];
}
@end
