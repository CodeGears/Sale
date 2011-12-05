//
//  CallObjective.h
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallObjective : NSObject
{
    NSString *_objective;
    NSString *_product;
    NSString *_result;
    NSString *_complaint;
    NSString *_samples;
}

@property (nonatomic, retain) NSString *objective;
@property (nonatomic, retain) NSString *product;
@property (nonatomic, retain) NSString *result;
@property (nonatomic, retain) NSString *complaint;
@property (nonatomic, retain) NSString *samples;

@end
