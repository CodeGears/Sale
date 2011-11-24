//
//  CustomerMember.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/23/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerMember : NSObject

{
    NSString* number;
    NSString* name;
    NSDate* endDate;
    NSDate* beginDate;
}
@property(nonatomic, retain) NSString* number;
@property(nonatomic, retain)  NSString* name;
@property(nonatomic, retain)  NSDate* endDate;
@property(nonatomic, retain)  NSDate* beginDate;

@end
