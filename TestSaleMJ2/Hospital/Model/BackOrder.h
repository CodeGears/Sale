//
//  BackOrder.h
//  Sale
//
//  Created by iterate on 11/23/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackOrder : NSObject
{
    NSDate *_date;
    
    NSString *_orderId;
    NSString *_product;
    NSString *_quantity;
    NSString *_free;
    NSString *_amount;
    NSString *_reason;
}

@property (nonatomic, retain) NSDate   *date;
@property (nonatomic, retain) NSString *orderId;
@property (nonatomic, retain) NSString *product;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) NSString *free;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *reason;

@end
