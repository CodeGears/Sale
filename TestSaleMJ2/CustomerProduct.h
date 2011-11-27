//
//  CustomerProduct.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/24/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerProduct : NSObject
{ NSString *name;
    NSString *code;
    NSString *recQty;
    
}

@property(nonatomic, retain) NSString *name;

@property(nonatomic, retain,readwrite) NSString *code;
@property(nonatomic,retain) NSString *recQty;


@end
