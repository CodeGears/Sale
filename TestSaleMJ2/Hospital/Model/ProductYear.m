//
//  ProductYear.m
//  Sale
//
//  Created by iterate on 11/23/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "ProductYear.h"

@implementation ProductYear

@synthesize january   = _january;
@synthesize febuary   = _febuary;
@synthesize march     = _march;
@synthesize april     = _april;
@synthesize may       = _may;
@synthesize june      = _june;
@synthesize july      = _july;
@synthesize august    = _august;
@synthesize september = _september;
@synthesize october   = _october;
@synthesize november  = _november;
@synthesize dececmber = _december;

- (id)init
{
    if (self = [super init]) {
        _january   = [[NSString stringWithFormat:@"Sample January"] retain];
        _febuary   = [[NSString stringWithFormat:@"Sample Febuary"] retain];
        _march     = [[NSString stringWithFormat:@"Sample March"] retain];
        _april     = [[NSString stringWithFormat:@"Sample April"] retain];
        _may       = [[NSString stringWithFormat:@"Sample May"] retain];
        _june      = [[NSString stringWithFormat:@"Sample June"] retain];
        _july      = [[NSString stringWithFormat:@"Sample July"] retain];
        _august    = [[NSString stringWithFormat:@"Sample August"] retain];
        _september = [[NSString stringWithFormat:@"Sample September"] retain];
        _october   = [[NSString stringWithFormat:@"Sample October"] retain];
        _november  = [[NSString stringWithFormat:@"Sample November"] retain];
        _december  = [[NSString stringWithFormat:@"Sample December"] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_january release];
    [_febuary release];
    [_march release];
    [_april release];
    [_may release];
    [_june release];
    [_july release];
    [_august release];
    [_september release];
    [_october release];
    [_november release];
    [_december release];
    
    [super dealloc];
}

@end
