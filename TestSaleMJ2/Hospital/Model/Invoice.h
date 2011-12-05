//
//  Invoice.h
//  Sale
//
//  Created by iterate on 11/23/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Invoice : NSObject
{
    NSDate *_date;
    
    NSString *_invoiceId;
    NSString *_product;
    NSString *_quantity;
    NSString *_free;
    NSString *_amount;
}

@property (nonatomic, retain) NSDate *date;

@property (nonatomic, retain) NSString *invoiceId;
@property (nonatomic, retain) NSString *product;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) NSString *free;
@property (nonatomic, retain) NSString *amount;


+ (NSMutableArray *)getInvoicesForHospitalId:(NSString *)hospitalId;

@end
