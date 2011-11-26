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

@property (nonatomic,assign,readwrite)BOOL Recommender;
@property (nonatomic,assign,readwrite) BOOL RoCommPTC;
@property (nonatomic,assign,readwrite) BOOL DepartmentHead;
@property (nonatomic,assign,readwrite) BOOL KOL;
@property (nonatomic,assign,readwrite) BOOL EndUseer;
@property (nonatomic,assign,readwrite) BOOL DirecAsstDirec;
@property (nonatomic,assign, readwrite)BOOL PedOBNurse;
@property (nonatomic,assign, readwrite)BOOL PedOBDoctor;
@property (nonatomic,assign, readwrite)BOOL Depo;
@property (nonatomic,assign , readwrite) BOOL PregList;



@end
