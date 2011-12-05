//
//  ProductEntry.h
//  Sale
//
//  Created by iterate on 12/5/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductEntry : NSObject
{
    NSString *_entryId;
    NSString *_productCode;
    NSString *_productName;
    NSString *_quantity;
    NSString *_foc;
    NSString *_unit;
    NSString *_price;
    NSString *_amount;
    
    NSString *_stock;
}

@property (nonatomic, retain) NSString *entryId;
@property (nonatomic, retain) NSString *productCode;
@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) NSString *quantity;
@property (nonatomic, retain) NSString *foc;
@property (nonatomic, retain) NSString *unit;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSString *stock;

@end
