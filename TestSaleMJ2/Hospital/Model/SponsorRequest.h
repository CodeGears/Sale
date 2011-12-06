//
//  SponsorRequest.h
//  Sale
//
//  Created by iterate on 12/5/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SponsorRequest : NSObject
{
    NSString *_documentNumber;
    NSString *_profileCode;
    NSString *_customerName;
    NSString *_description;
    NSString *_infomation;
    NSString *_payTo;
    NSString *_type;
    NSString *_amount;
    
    NSDate *_requireDate;
}

@property (nonatomic, retain) NSString *documentNumber;
@property (nonatomic, retain) NSString *profileCode;
@property (nonatomic, retain) NSString *customerName;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *infomation;
@property (nonatomic, retain) NSString *payTo;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *amount;
@property (nonatomic, retain) NSDate *requireDate;

@end
