//
//  CustomerChild.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/22/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "CustomerChild.h"

@implementation CustomerChild

@synthesize number;
@synthesize titleName;
@synthesize firstName;
@synthesize lastName;
@synthesize sex;
@synthesize birthDate;

-(void)dealloc{
    [number release];
    [titleName release];
    [firstName release];
    [lastName release];
    [sex release];
    [birthDate release];
    [super dealloc];
}

@end
