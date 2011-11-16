//
//  DetailViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

#import "RootViewController.h"

//Tab menu screen
#import "CustomerDetailViewController.h"
#import "CallHistoryViewController.h"
#import "SellHistoryViewController.h"



@implementation DetailViewController

@synthesize segmentBar = _segmentBar;
@synthesize rootview = _rootView;


#pragma - POPOver Handle
- (IBAction) CreatePopOverController:(id)sender{
    
    
    if (!popOverCtrl) {
        UIViewController* viewCtrl = [[UIViewController alloc] init];
  
        
        popOverCtrl = [[UIPopoverController alloc] initWithContentViewController:viewCtrl];
        [popOverCtrl setDelegate:self];
        
        
        [viewCtrl release];
    }
    
    
    [popOverCtrl presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:TRUE];
    
}

- (IBAction) CreateNewView:(id)sender{
    if (!createNewViewCtrl) {
        createNewViewCtrl = [[UIViewController alloc] initWithNibName:@"NewCustomer" bundle:nil];
    }
    
    //[viewCtrl setModalInPopover:TRUE];
    [createNewViewCtrl setModalPresentationStyle:UIModalPresentationFormSheet];
    [createNewViewCtrl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    
    [self presentModalViewController:createNewViewCtrl animated:YES];
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"pop over dismiss");
}


#pragma mark - Load Detail
- (void) LoadNewDetailView{
    [detailNavigation release];
    
    CustomerDetailViewController* createView = [[CustomerDetailViewController alloc] initWithNibName:@"CustomerDetail" bundle:nil];
    [createView setTitle:@"Customer Detail"];
    
    
    detailNavigation = [[UINavigationController alloc] initWithRootViewController:createView];
    
    [createView SetParentNavigator:detailNavigation];
    [createView release];
    
    [detailNavigation setDelegate: self];
    [detailNavigation setWantsFullScreenLayout:false];
    [[detailNavigation view] setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
    //[detailNavigation.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    //[self.view bringSubviewToFront:_toolbar];
    
    [self.view addSubview:detailNavigation.view];
    
    //Create Header
    [detailNavigation setTitle:@"Customer Detail"];
}

#pragma mark - Handle seqmented button
- (IBAction) HitSegmentBt{
    //NSLog(@"Hit it %d", [_segmentBar selectedSegmentIndex]);
    
    if ([_segmentBar selectedSegmentIndex] == 0) {
        
        [self LoadNewDetailView];
    }
    else if ([_segmentBar selectedSegmentIndex] == 1) {
        [detailNavigation release];
        
        CallHistoryViewController* createView = [[CallHistoryViewController alloc] initWithNibName:@"CallHistory" bundle:nil];
        [createView setTitle:@"Call History"];
        
        detailNavigation = [[UINavigationController alloc] initWithRootViewController:createView];
        
        [createView SetParentNavigator:detailNavigation];
        [createView release];
        
        [detailNavigation setDelegate: self];
        [detailNavigation setWantsFullScreenLayout:false];
        [[detailNavigation view] setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
        //[detailNavigation.navigationBar setBarStyle:UIBarStyleBlackOpaque];
        
        //[self.view bringSubviewToFront:_toolbar];
        
        [self.view addSubview:detailNavigation.view];
        
        //Create Header
        [detailNavigation setTitle:@"Call History"];
    }
    else{
        [detailNavigation release];
        
        SellHistoryViewController* createView = [[SellHistoryViewController alloc] initWithNibName:@"SellHistoryViewController" bundle:nil];
        [createView setTitle:@"Sales History"];
       
        detailNavigation = [[UINavigationController alloc] initWithRootViewController:createView];
        
        //[createView SetParentNavigator:detailNavigation];
        [createView release];
        
        [detailNavigation setDelegate: self];
        [detailNavigation setWantsFullScreenLayout:false];
        [[detailNavigation view] setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
        //[detailNavigation.navigationBar setBarStyle:UIBarStyleBlackOpaque];
        
        //[self.view bringSubviewToFront:_toolbar];
        
        [self.view addSubview:detailNavigation.view];
        
        //Create Header
        [detailNavigation setTitle:@"Sell History"];
    }
    
    
    // [self.view bringSubviewToFront:_toolbar];
}


#pragma mark - Managing the detail item



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create CustomerDetail as root
    CustomerDetailViewController* view = [[CustomerDetailViewController alloc] initWithNibName:@"CustomerDetail" bundle:nil];
    [view setTitle:@"Customer Detail"];
    
    detailNavigation = [[UINavigationController alloc] initWithRootViewController:view];
    
    [view SetParentNavigator:detailNavigation];
    [view release];
    
    [detailNavigation setDelegate: self];
    [detailNavigation setWantsFullScreenLayout:false];
    [[detailNavigation view] setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
    //[detailNavigation.navigationBar setBarStyle:UIBarStyleBlackOpaque];
   
    [self.view addSubview:detailNavigation.view];
    
    
    //Set segment select detail
    [_segmentBar setSelectedSegmentIndex:0];
    
 
   
    
    //[self.view bringSubviewToFront:_toolbar];
}
 

- (void)viewDidUnload
{
	[super viewDidUnload];

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//self.popoverController = nil;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [detailNavigation release];
   
    [super dealloc];
}

@end
