//
//  CustomerList.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/22/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "CustomerList.h"

@implementation CustomerList

@synthesize name;
@synthesize profileCode;
@synthesize customerCode;
@synthesize grade;
@synthesize isActive;

-(void)dealloc
{
    [name release];
    [profileCode release];
    [customerCode release];
    [grade release];
    
    [super dealloc];
    
}

@end
