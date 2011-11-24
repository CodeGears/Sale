//
//  CustomerChild.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/22/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerChild : NSObject
{
    NSString* number;
    NSString* titleName;
    NSString* firstName;
    NSString* lastName;
    NSString* sex;
    NSDate* birthDate;
}

@property(nonatomic, retain) NSString* number;
@property(nonatomic, retain) NSString* titleName;
@property(nonatomic, retain) NSString* firstName;
@property(nonatomic, retain) NSString* lastName;
@property(nonatomic, retain) NSString* sex;
@property(nonatomic, retain) NSDate* birthDate;

@end
