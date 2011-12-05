//
//  MarketIntelligence.m
//  Sale
//
//  Created by iterate on 12/5/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "MarketIntelligence.h"

@implementation MarketIntelligence

@synthesize documentNumber  = _documentNumber;
@synthesize profileCode     = _profileCode;
@synthesize topicType       = _topicType;
@synthesize company         = _company;
@synthesize eventDetail     = _eventDetail;
@synthesize actionTake      = _actionTake;
@synthesize firstImageData  = _firstImageData;
@synthesize secondImageData = _secondImageData;
@synthesize thirdImageData  = _thirdImageData;
@synthesize fourthImageData = _fourthImageData;

- (id)init
{
    if (self = [super init]) {
        _documentNumber  = [[NSString string] retain];
        _profileCode     = [[NSString string] retain];
        _topicType       = [[NSString string] retain];
        _company         = [[NSString string] retain];
        _eventDetail     = [[NSString string] retain];
        _actionTake      = [[NSString string] retain];
        _firstImageData  = [[NSData data] retain];
        _secondImageData = [[NSData data] retain];
        _thirdImageData  = [[NSData data] retain];
        _fourthImageData = [[NSData data] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_documentNumber release];
    [_profileCode release];
    [_topicType release];
    [_company release];
    [_eventDetail release];
    [_actionTake release];
    
    [_firstImageData release];
    [_secondImageData release];
    [_thirdImageData release];
    [_fourthImageData release];

    
    [super dealloc];
}
@end
