//
//  HospitalBirthRate.m
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "HospitalBirthRate.h"

@implementation HospitalBirthRate

@synthesize year = _year;

- (id)init
{
    if (self = [super init])
    {
        _year = [[NSString stringWithFormat:@"Sample Year"] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [_year release];
    
    [super dealloc];
}

@end
