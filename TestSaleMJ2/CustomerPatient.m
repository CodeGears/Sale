//
//  CustomerPatient.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/24/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "CustomerPatient.h"

@implementation CustomerPatient
@synthesize type;
@synthesize totalBirth;
@synthesize totalCommercial;

- (void)dealloc {
    [type release];
    [totalCommercial release];
    [totalBirth release];
    
    [super dealloc];
}

@end
