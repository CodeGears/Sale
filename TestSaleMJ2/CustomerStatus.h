//
//  CustomerStatus.h
//  TestSaleMJ2
//
//  Created by CRM Charity on 11/24/54 BE.
//  Copyright (c) 2554 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomerStatus : NSObject
{ BOOL Recommender;
    BOOL RoCommPTC;
    BOOL DepartmentHead;
    BOOL KOL;
    BOOL EndUseer;
    BOOL DirecAsstDirec;
    BOOL PedOBNurse;
    BOOL PedOBDoctor;
    BOOL Depo;
    BOOL PregList;
    
}

@property (nonatomic)BOOL Recommender;
@property (nonatomic) BOOL RoCommPTC;
@property (nonatomic) BOOL DepartmentHead;
@property (nonatomic) BOOL KOL;
@property (nonatomic) BOOL EndUseer;
@property (nonatomic) BOOL DirecAsstDirec;
@property (nonatomic)BOOL PedOBNurse;
@property (nonatomic)BOOL PedOBDoctor;
@property (nonatomic)BOOL Depo;
@property (nonatomic) BOOL PregList;



@end
