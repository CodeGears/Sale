//
//  EvaluationRequest.h
//  Sale
//
//  Created by iterate on 12/5/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationRequest : NSObject
{
    NSString *_evaluationRequestId;
    NSString *_customerCode;
    NSString *_category;
    NSString *_reaCode;
    NSString *_address;
    NSString *_spdQuantity;
    
    NSString *_linkOrder;
    NSString *_firstRemark;
    NSString *_secondRemark;
    
    NSData *_certifySignatureData;
}

@property (nonatomic, retain) NSString *evaluationRequestId;
@property (nonatomic, retain) NSString *customerCode;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *reaCode;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *spdQuantity;

@property (nonatomic, retain) NSString *linkOrder;
@property (nonatomic, retain) NSString *firstRemark;
@property (nonatomic, retain) NSString *secondRemark;
@property (nonatomic, retain) NSData *certifySignatureData;

@end
