//
//  CustomerMember.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/23/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "CustomerMember.h"

@implementation CustomerMember
@synthesize name;
@synthesize number;
@synthesize endDate;
@synthesize beginDate;

- (void)dealloc {
    [name release];
    [number release];
    [endDate release];
    [beginDate release];
    [super dealloc];
}

@end
