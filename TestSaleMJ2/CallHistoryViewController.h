//
//  CallHistoryViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CallHistoryViewController : UITableViewController < UIPopoverControllerDelegate, UINavigationControllerDelegate> 
{
    
    UINavigationController* parentNavigator;
    
    NSDictionary* dicData;
    NSArray*    keys;
    
    UITableViewCell* cellHeader;
    UITableViewCell* cell4Column;
}

@property (nonatomic, assign) IBOutlet UITableViewCell* cellHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cell4Column;


- (void) SetParentNavigator:(UINavigationController*)navi;
- (IBAction) HitCallHistoryBt;

@end
