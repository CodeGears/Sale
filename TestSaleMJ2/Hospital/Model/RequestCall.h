//
//  RequestCall.h
//  Sale
//
//  Created by iterate on 11/22/11.
//  Copyright (c) 2011 Quadsolutions Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CallObjective;

@interface RequestCall : NSObject
{
    NSDate *_date;
    
    NSString *_profileCode;
    NSString *_hospitalName;
    NSString *_grade;
    NSString *_note;
    
    CallObjective *_firstObjective;
    CallObjective *_secondObjective;
    CallObjective *_thirdObjective;
    
    NSString *_firstSupervisor;
    NSString *_secondSupervisor;
    NSString *_thirdSupervisor;
    
}


@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *profileCode;
@property (nonatomic, retain) NSString *hospitalName;
@property (nonatomic, retain) NSString *grade;
@property (nonatomic, retain) NSString *note;

@property (nonatomic, retain) CallObjective *firstObjective;
@property (nonatomic, retain) CallObjective *secondObjective;
@property (nonatomic, retain) CallObjective *thirdObjective;

@property (nonatomic, retain) NSString *firstSupervisor;
@property (nonatomic, retain) NSString *secondSupervisor;
@property (nonatomic, retain) NSString *thirdSupervisor;

@end
