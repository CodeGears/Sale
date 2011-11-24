//
//  Hobby.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/23/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hobby : NSObject

{
    NSString* name;
    NSString* description;
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *description;

@end
