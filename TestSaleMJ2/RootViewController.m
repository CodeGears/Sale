//
//  RootViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "NewCustomerViewController.h"

#import "CustomerDataManager.h"
#import "CustomerTypePopoverViewCTRL.h"

@implementation RootViewController
		
@synthesize tableView, tabBar, naviBar;
@synthesize detailView;


- (void) SetOwnDetailView:(DetailViewController *)view{
    detailView = view;
}

#pragma - POPOver Handle
- (IBAction) CreatePopOverController:(id)sender{
    
    CustomerTypePopoverViewCTRL* viewCtrl = [[CustomerTypePopoverViewCTRL alloc] init];
    
    if (!popOverCtrl) {
        popOverCtrl = [[UIPopoverController alloc] initWithContentViewController:viewCtrl];
        [popOverCtrl setDelegate:self];
    }
    
    [viewCtrl setParentPopup:popOverCtrl];
    [viewCtrl release];
    
    
    [popOverCtrl presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:TRUE];
    
}

- (IBAction) CreateNewView:(id)sender{
    if (!createNewViewCtrl) {
        createNewViewCtrl = [[NewCustomerViewController alloc] initWithNibName:@"NewCustomer" bundle:nil];
    }
    
    //[viewCtrl setModalInPopover:TRUE];
    [createNewViewCtrl setModalPresentationStyle:UIModalPresentationFormSheet];
    [createNewViewCtrl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
  
    [self presentModalViewController:createNewViewCtrl animated:YES];
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"pop over dismiss");
}




#pragma - VIEW Handle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //tableView.clearsSelectionOnViewWillAppear = NO;
    [tableView setDelegate:self];
    
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    
    [tabBar setSelectedItem:[[tabBar items] objectAtIndex:0]];
    
    
    localNameKeys = [[CustomerDataManager sharedInstance] GetCustomerNameKeys];
    localNameList = [[CustomerDataManager sharedInstance] GetCustomerNameList:@""];
}

		
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


#pragma - Table Handle
		
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [localNameKeys count];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [localNameKeys objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[localNameList objectAtIndex:section] count];
    		
}

		
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    NSArray* array = [localNameList objectAtIndex:indexPath.section];
    
    ContactProfile* profile = [array objectAtIndex:indexPath.row];

    cell.textLabel.text = profile.name;  
    cell.detailTextLabel.text = profile.group;
    
    if (profile.isActive) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    		
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here -- for example, create and push another view controller.
    [detailView LoadNewDetailView];
}

#pragma - Destructor Handle

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [popOverCtrl release];
    [createNewViewCtrl release];
    [super dealloc];
}

@end
//