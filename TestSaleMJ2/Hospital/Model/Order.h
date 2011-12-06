//
//  Order.h
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
{   
    NSString *_customerCode;
    NSString *_role;
    NSString *_address;
    NSString *_hospital;
    NSString *_category;
    
    NSString *_orderId;
    NSString *_poId;
    NSString *_saleQuality;
    NSString *_focQuality;
    NSString *_spdQuality;
    NSString *_totalAmount;
    NSString *_firstRemark;
    NSString *_secondRemark;
    
    NSString *_billTo;
    NSString *_shipTo;
}

@property (nonatomic, retain) NSString *customerCode;
@property (nonatomic, retain) NSString *role;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *hospital;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *orderId;
@property (nonatomic, retain) NSString *poId;
@property (nonatomic, retain) NSString *saleQuality;
@property (nonatomic, retain) NSString *focQuality;
@property (nonatomic, retain) NSString *spdQuality;
@property (nonatomic, retain) NSString *totalAmount;
@property (nonatomic, retain) NSString *firstRemark;
@property (nonatomic, retain) NSString *secondRemark;

@property (nonatomic, retain) NSString *billTo;
@property (nonatomic, retain) NSString *shipTo;

@end
