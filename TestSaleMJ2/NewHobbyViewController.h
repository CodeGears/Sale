//
//  NewHobbyViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewHobbyViewController : UIViewController 
    <UIPopoverControllerDelegate> {
    UIPopoverController* popOverCtrl;
}

@property (nonatomic, retain) IBOutlet UITextField* hobbyTypeTextField;
@property (nonatomic, retain) IBOutlet UITextField* hobbyDescTextField;

- (IBAction) HitCancel:(id)sender;
- (IBAction) HitDone:(id)sender;

- (IBAction) CreatePopOverController:(id)sender;

@end
