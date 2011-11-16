//
//  DetailViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomerDetailViewController;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UINavigationControllerDelegate> {
    
    
    UINavigationController* detailNavigation;
    
    UIViewController* createNewViewCtrl;
    UIPopoverController* popOverCtrl;
}


//@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentBar;
@property (nonatomic, retain) IBOutlet UIViewController* rootview;

- (IBAction) CreatePopOverController:(id)sender;
- (IBAction) CreateNewView:(id)sender;

- (IBAction) HitSegmentBt;

- (void) LoadNewDetailView;

@end
