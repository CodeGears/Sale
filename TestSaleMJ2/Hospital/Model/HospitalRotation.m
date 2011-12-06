//
//  HospitalRotation.m
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import "HospitalRotation.h"
#import "ProductYear.h"

@implementation HospitalRotation

@synthesize year          = _year;
@synthesize rotationType  = _rotationType;
@synthesize firstProduct  = _firstProduct;
@synthesize secondProduct = _secondProduct;

- (id)init
{
    if(self = [super init]) {
        _year          = [[NSString stringWithFormat:@"Sample Year"] retain];
        _rotationType  = [[NSString stringWithFormat:@"Sample Rotation Type"] retain];
        
        _firstProduct  = [[ProductYear alloc] init];
        _secondProduct = [[ProductYear alloc] init];
    }
    
    return self;
}


- (void)dealloc
{ 
    [_year release];
    [_rotationType release];
    
    [_firstProduct release];
    [_secondProduct release];
    
    [super dealloc];
}

@end
