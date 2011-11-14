//
//  HobbyDetailViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HobbyDetailViewController : UIViewController  <UIPopoverControllerDelegate> {
    UIPopoverController* popOverCtrl;    
}

- (IBAction) CreatePopOverController:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField* hobbyTypeTextField;
@property (nonatomic, retain) IBOutlet UITextField* hobbyDescTextField;

@end
