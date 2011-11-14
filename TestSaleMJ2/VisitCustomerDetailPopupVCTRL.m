//
//  VisitCustomerDetailPopupVCTRL.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitCustomerDetailPopupVCTRL.h"

//Visit screen
#import "VisitRecordCallViewController.h"
#import "VisitOrderViewController.h"
#import "VisitMarketIntViewController.h"
#import "VisitSponsorRequestViewController.h"
#import "VisitMarketSurveyViewController.h"
#import "VisitCustomerComplaintViewController.h"
#import "VisitProductEvaluatViewController.h"

@implementation VisitCustomerDetailPopupVCTRL

@synthesize parentPopup;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [keys release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    keys = [[NSArray alloc] initWithObjects:@"Record call",@"Order", @"Product evaluation request", @"Market intelligence", @"Customer complaint", @"Sponsor request", @"Market Survey", nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma - Table Handle

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [keys count];
    
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    cell.textLabel.text = [keys objectAtIndex:indexPath.row];
    //[cell setEditingAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    
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

//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"end edit");
//}
//
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"Begin edit");
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"edit");
//}
//
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"Visit";
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here -- for example, create and push another view controller.
    
    if ( [[keys objectAtIndex:indexPath.row] isEqualToString:@"Record call"]) {
        VisitRecordCallViewController* v = [[VisitRecordCallViewController alloc] initWithNibName:@"VisitRecordCallViewController" bundle:nil];
        
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:v];
        
        //[self setModalInPopover:TRUE];
        [navi setModalPresentationStyle:UIModalPresentationPageSheet];
        [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        
        [self presentModalViewController:navi animated:YES];
        
        [v release];
        [navi release];
    }
    else if ( [[keys objectAtIndex:indexPath.row] isEqualToString:@"Order"]) {
        VisitOrderViewController* v = [[VisitOrderViewController alloc] initWithNibName:@"VisitOrderViewController" bundle:nil];
        
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:v];
        
        //[self setModalInPopover:TRUE];
        [navi setModalPresentationStyle:UIModalPresentationPageSheet];
        [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        
        [self presentModalViewController:navi animated:YES];
        
        [v release];
        [navi release];
    }
    else if ( [[keys objectAtIndex:indexPath.row] isEqualToString:@"Product evaluation request"]) {
        VisitProductEvaluatViewController* v = [[VisitProductEvaluatViewController alloc] initWithNibName:@"VisitProductEvaluatViewController" bundle:nil];
        
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:v];
        
        //[self setModalInPopover:TRUE];
        [navi setModalPresentationStyle:UIModalPresentationPageSheet];
        [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        
        [self presentModalViewController:navi animated:YES];
        
        [v release];
        [navi release];
    }
    else if ( [[keys objectAtIndex:indexPath.row] isEqualToString:@"Market intelligence"]) {
        VisitMarketIntViewController* v = [[VisitMarketIntViewController alloc] initWithNibName:@"VisitMarketIntViewController" bundle:nil];
        
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:v];
        
        //[self setModalInPopover:TRUE];
        [navi setModalPresentationStyle:UIModalPresentationPageSheet];
        [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        
        [self presentModalViewController:navi animated:YES];
        
        [v release];
        [navi release];
    }
    else if ( [[keys objectAtIndex:indexPath.row] isEqualToString:@"Customer complaint"]) {
        VisitCustomerComplaintViewController* v = [[VisitCustomerComplaintViewController alloc] initWithNibName:@"VisitCustomerComplaintViewController" bundle:nil];
        
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:v];
        
        //[self setModalInPopover:TRUE];
        [navi setModalPresentationStyle:UIModalPresentationPageSheet];
        [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        
        [self presentModalViewController:navi animated:YES];
        
        [v release];
        [navi release];
    }
    else if ( [[keys objectAtIndex:indexPath.row] isEqualToString:@"Sponsor request"]) {
        VisitSponsorRequestViewController* v = [[VisitSponsorRequestViewController alloc] initWithNibName:@"VisitSponsorRequestViewController" bundle:nil];
        
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:v];
        
        //[self setModalInPopover:TRUE];
        [navi setModalPresentationStyle:UIModalPresentationPageSheet];
        [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        
        [self presentModalViewController:navi animated:YES];
        
        [v release];
        [navi release];
    }
    else if ( [[keys objectAtIndex:indexPath.row] isEqualToString:@"Market Survey"]) {
        VisitMarketSurveyViewController* v = [[VisitMarketSurveyViewController alloc] initWithNibName:@"VisitMarketSurveyViewController" bundle:nil];
        
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:v];
        
        //[self setModalInPopover:FALSE];
        
        [navi setModalPresentationStyle:UIModalPresentationPageSheet];
        [navi setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        
        
        [self presentModalViewController:navi animated:YES];
        
        [v release];
        [navi release];
    }
    else{
        UIViewController* v = [[UIViewController alloc] initWithNibName:@"Blank" bundle:nil];
        [v setTitle:[keys objectAtIndex:indexPath.row]];
        
        [self presentModalViewController:v animated:YES];
        [v release];
    }
    
    //buggy
    [parentPopup dismissPopoverAnimated:YES];
}

@end
