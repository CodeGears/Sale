//
//  CustomerWorkPlace.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/23/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerWorkPlace : NSObject

{
    NSString* hospitalName;
    NSString* department;
    NSString* building;
    NSString* workTime;
}
@property(nonatomic, retain)NSString* hospitalName;
@property(nonatomic, retain)NSString* department;
@property(nonatomic, retain)NSString* building;
@property(nonatomic, retain)NSString* workTime;
@end
