//
//  CustomerTypePopoverViewCTRL.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomerTypePopoverViewCTRL : UITableViewController {
    UIPopoverController* parentPopup;
}

@property (nonatomic, assign) UIPopoverController* parentPopup;

@end
