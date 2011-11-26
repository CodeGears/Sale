//
//  CallHistory.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/25/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallHistory : NSObject
{ NSString* number;
    NSString* date;
    NSString* objective;
    NSString* product;
    NSString* result;
    NSString* complaint;
    NSString* sample;
    NSString* remark;
}

@property (retain, nonatomic) NSString* number;
@property (retain, nonatomic) NSString* date;
@property (retain, nonatomic) NSString* objective;
 @property (retain, nonatomic) NSString* product;
@property (retain, nonatomic) NSString* result;
@property (retain, nonatomic) NSString* complaint;
@property (retain, nonatomic) NSString* sample;
@property (retain, nonatomic) NSString* remark;

@end
