//
//  SalesHistory.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/26/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesHistory : NSObject
{
    
    NSString* date;
    NSString* number;
    NSString* product;
    NSString* quantity;
    NSString* unitPrice;
    NSString* free;
    NSString* amount;
    NSString* reason;
}

@property(retain, nonatomic)    NSString* date;
@property(retain, nonatomic)   NSString* number;
@property(retain, nonatomic)  NSString* product;
@property(retain, nonatomic)  NSString* quantity;
@property(retain, nonatomic) NSString* unitPrice;
@property(retain, nonatomic)  NSString* free;
@property(retain, nonatomic)   NSString* amount;
@property(retain, nonatomic)   NSString* reason;

@end
