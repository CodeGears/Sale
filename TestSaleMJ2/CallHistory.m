//
//  CallHistory.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/25/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "CallHistory.h"

@implementation CallHistory
@synthesize number;
@synthesize date;
@synthesize objective;
@synthesize product;
@synthesize result;
@synthesize complaint;
@synthesize sample;
@synthesize remark;

- (void)dealloc {
    [number release];
    [date release];
    [objective release];
    [product release];
    [result release];
    [complaint release];
    [sample release];
    [remark release];
    [super dealloc];
}

@end
