//
//  HobbyTypePopOverViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HobbyTypePopOverViewController : UITableViewController {
    UIPopoverController* parentPopup;
    
    UIViewController* delegate;
}

@property (nonatomic, assign) UIPopoverController* parentPopup;

@property (nonatomic, assign) UIViewController* delegate;


@end
