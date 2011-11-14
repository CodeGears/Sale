//
//  CertifyViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CertifyViewController.h"


@implementation CertifyViewController


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

#pragma mark - Action
- (IBAction) HitDone:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) HitCancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction) HitClear:(id)sender{
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
