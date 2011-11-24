//
//  CustomerList.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/22/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerList : NSObject

{
    
    NSString *name;
    NSString *profileCode;
    NSString *customerCode;
    NSString *grade;
    BOOL isActive;
}
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *profileCode;
@property(nonatomic,retain) NSString *customerCode;
@property(nonatomic,retain) NSString *grade;
@property(nonatomic) BOOL isActive;
@end
