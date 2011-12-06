//
//  RequestCall.m
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "RequestCall.h"
#import "CallObjective.h"

@implementation RequestCall

@synthesize date             = _date;

@synthesize profileCode      = _profileCode;
@synthesize hospitalName     = _hospitalName;
@synthesize grade            = _grade;
@synthesize note             = _note;

@synthesize firstObjective   = _firstObjective;
@synthesize secondObjective  = _secondObjective;
@synthesize thirdObjective   = _thirdObjective;

@synthesize firstSupervisor  = _firstSupervisor;
@synthesize secondSupervisor = _secondSupervisor;
@synthesize thirdSupervisor  = _thirdSupervisor;

- (id)init
{
    if (self = [super init]) {
        
        _firstObjective  = [[CallObjective alloc] init];
        _secondObjective = [[CallObjective alloc] init];
        _thirdObjective  = [[CallObjective alloc] init];
        
        _profileCode     = [[NSString stringWithFormat:@"Sample Code"] retain];
        _hospitalName    = [[NSString stringWithFormat:@"Sample Hospital"] retain];
        _grade           = [[NSString stringWithFormat:@"Sample Grade"] retain];
        _note            = [[NSString stringWithFormat:@"Sample Note"] retain];
        
        _firstSupervisor  = [[NSString stringWithFormat:@"Sample Supervisor 1"] retain];
        _secondSupervisor = [[NSString stringWithFormat:@"Sample Supervisor 2"] retain];
        _thirdSupervisor  = [[NSString stringWithFormat:@"Sample Supervisor 3"] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_profileCode release];
    [_hospitalName release];
    [_grade release];
    [_note release];
    
    [_firstObjective release];
    [_secondObjective release];
    [_thirdObjective release];
    
    [_firstSupervisor release];
    [_secondSupervisor release];
    [_thirdSupervisor release];
    
    [super dealloc];
}

@end
