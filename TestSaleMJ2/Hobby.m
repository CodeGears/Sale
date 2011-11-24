//
//  Hobby.m
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/23/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import "Hobby.h"

@implementation Hobby
@synthesize name;
@synthesize description;

- (void)dealloc {
    [name release];
    [description release];
    [super dealloc];
}
@end
