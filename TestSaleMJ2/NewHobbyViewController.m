//
//  NewHobbyViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewHobbyViewController.h"
#import "HobbyTypePopOverViewController.h"

#import "CustomerDataManager.h"

@implementation NewHobbyViewController
@synthesize hobbyDescTextField,hobbyTypeTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [popOverCtrl release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma - POPOver Handle
- (IBAction) CreatePopOverController:(id)sender{
    
    HobbyTypePopOverViewController* viewCtrl = [[HobbyTypePopOverViewController alloc] init];
    
    if (!popOverCtrl) {
        popOverCtrl = [[UIPopoverController alloc] initWithContentViewController:viewCtrl];
        [popOverCtrl setDelegate:self];
    }
    
    [viewCtrl setDelegate:self];
    [viewCtrl setParentPopup:popOverCtrl];
    
    
    [viewCtrl release];
    
    UIButton* bt = sender;
    
    
    [popOverCtrl presentPopoverFromRect:CGRectMake(bt.frame.origin.x/2, 0, bt.frame.origin.x, bt.frame.origin.y ) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:TRUE];
    
}

- (void) PerformPopupSelect:(id)text{
    hobbyTypeTextField.text = (NSString*)text;
}

#pragma - IBAction handle

- (IBAction) HitDone:(id)sender{
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction) HitCancel:(id)sender{
    [self dismissModalViewControllerAnimated:TRUE];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
