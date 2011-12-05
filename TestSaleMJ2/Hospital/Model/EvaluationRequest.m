//
//  EvaluationRequest.m
//  Sale
//
//  Created by iterate on 12/5/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "EvaluationRequest.h"

@implementation EvaluationRequest

@synthesize evaluationRequestId  = _evaluationRequestId;
@synthesize customerCode         = _customerCode;
@synthesize category             = _category;
@synthesize reaCode              = _reaCode;
@synthesize address              = _address;
@synthesize spdQuantity          = _spdQuantity;
@synthesize linkOrder            = _linkOrder;
@synthesize firstRemark          = _firstRemark;
@synthesize secondRemark         = _secondRemark;
@synthesize certifySignatureData = _certifySignatureData;

- (id)init
{
    if (self = [super init]) {
        _evaluationRequestId  = [[NSString string] retain];
        _customerCode         = [[NSString string] retain];
        _category             = [[NSString string] retain];
        _reaCode              = [[NSString string] retain];
        _address              = [[NSString string] retain];
        _spdQuantity          = [[NSString string] retain];
        _linkOrder            = [[NSString string] retain];
        _firstRemark          = [[NSString string] retain];
        _secondRemark         = [[NSString string] retain];
        _certifySignatureData = [[NSData data] retain];
    }
    
    return self;
}

- (void)dealloc
{
    
    [_evaluationRequestId release];
    [_customerCode release];
    [_category release];
    [_reaCode release];
    [_address release];
    [_spdQuantity release];
    [_linkOrder release];
    [_firstRemark release];
    [_secondRemark release];
    [_certifySignatureData release];
    
    [super dealloc];
}

@end
