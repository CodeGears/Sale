//
//  SponsorRequest.m
//  Sale
//
//  Created by iterate on 12/5/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "SponsorRequest.h"

@implementation SponsorRequest

@synthesize documentNumber = _documentNumber;
@synthesize profileCode    = _profileCode;
@synthesize customerName   = _customerName;
@synthesize description    = _description;
@synthesize infomation     = _infomation;
@synthesize payTo          = _payTo;
@synthesize type           = _type;
@synthesize amount         = _amount;
@synthesize requireDate    = _requireDate;

- (id)init
{
    if (self = [super init]) {
        
        _documentNumber = [[NSString string] retain];
        _profileCode    = [[NSString string] retain];
        _customerName   = [[NSString string] retain];
        _description    = [[NSString string] retain];
        _infomation     = [[NSString string] retain];
        _payTo          = [[NSString string] retain];
        _type           = [[NSString string] retain];
        _amount         = [[NSString string] retain];
        _requireDate    = [[NSString string] retain];
        
    }
    
    return self;
}

- (void)dealloc
{
    
    [_documentNumber release];
    [_profileCode release];
    [_customerName release];
    [_description release];
    [_infomation release];
    [_payTo release];
    [_type release];
    [_amount release];
    [_requireDate release];
}

@end
