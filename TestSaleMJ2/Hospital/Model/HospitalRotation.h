//
//  HospitalRotation.h
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductYear;

@interface HospitalRotation : NSObject
{
 
    NSString *_year;
    NSString *_rotationType;
    
    ProductYear *_firstProduct;
    ProductYear *_secondProduct;
}

@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *rotationType;
@property (nonatomic, retain) ProductYear *firstProduct;
@property (nonatomic, retain) ProductYear *secondProduct;

@end
