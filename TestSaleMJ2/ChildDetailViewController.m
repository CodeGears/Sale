//
//  ChildDetailViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 11/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChildDetailViewController.h"

#import "CustomerDataManager.h"

@implementation ChildDetailViewController
@synthesize childSexTextField,childenIDTextField,childNameTextField,childBirthDayTextField;

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
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray* temp = [[CustomerDataManager sharedInstance] GetCustomerDetailEditChildInfo:@"" WithChild:@""];
    
    childenIDTextField.text = [temp objectAtIndex:0];
    childNameTextField.text = [temp objectAtIndex:1];
    childSexTextField.text = [temp objectAtIndex:2];
    childBirthDayTextField.text = [temp objectAtIndex:3];
}


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
