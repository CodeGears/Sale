//
//  CustomerWorkPlace.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/23/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "CustomerWorkPlace.h"

@implementation CustomerWorkPlace

@synthesize hospitalName;
@synthesize department;
@synthesize building;
@synthesize workTime;

- (void)dealloc {
    [hospitalName release];
    [department release];
    [building release];
    [workTime release];
    [super dealloc];
}

@end
