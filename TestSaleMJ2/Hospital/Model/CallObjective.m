//
//  CallObjective.m
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "CallObjective.h"

@implementation CallObjective

@synthesize objective = _objective;
@synthesize product   = _product;
@synthesize result    = _result;
@synthesize complaint = _complaint;
@synthesize samples   = _samples;

- (id)init
{
    if (self = [super init]) 
    {
        _objective = [[NSString stringWithFormat:@"Sample Objective"] retain];
        _product   = [[NSString stringWithFormat:@"Sample Product"] retain];
        _result    = [[NSString stringWithFormat:@"Sample Result"] retain];
        _complaint = [[NSString stringWithFormat:@"Sample Complaint"] retain];
        _samples   = [[NSString stringWithFormat:@"Sample Samples"] retain];   
    }
    
    return self;
}

- (void)dealloc
{
    [_objective release];
    [_product release];
    [_result release];
    [_complaint release];
    [_samples release]; 
    
    [super dealloc];
}

@end