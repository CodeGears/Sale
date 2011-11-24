//
//  CustomerPatient.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/24/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerPatient : NSObject
{
    NSString* type;
    NSString* totalBirth;
    NSString* totalCommercial;
    
}
@property(nonatomic, retain) NSString* type;
@property(nonatomic, retain)NSString* totalBirth;
@property(nonatomic, retain)NSString* totalCommercial;



@end
