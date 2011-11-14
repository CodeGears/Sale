//
//  VisitProductEvaluatViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitProductEvaluatViewController.h"
#import "CertifyViewController.h"
#import "ProductAddPopupVCTRL.h"
#import "ProductAddDetailPopupVCTRL.h"

@implementation VisitProductEvaluatViewController
@synthesize cellProperty, cell6Column, cellHeader;

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
    
    [popOverCtrl release];
    [editPopOverCtrl release];
    
    [dicData release];
    [keys release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Selector

- (void)Cancel{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)Done{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) HitPopup:(id)sender{
    if (!popOverCtrl) {
        ProductAddPopupVCTRL* viewCtrl = [[ProductAddPopupVCTRL alloc] initWithNibName:@"ProductAddPopupVCTRL" bundle:nil];
        
        UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
        
        popOverCtrl = [[UIPopoverController alloc] initWithContentViewController:navi];
        [popOverCtrl setDelegate:self];
        
        [viewCtrl setParentPopup:popOverCtrl];
        
        [viewCtrl release];
        [navi release];
    }
    
    [((UINavigationController*)popOverCtrl.contentViewController) popToRootViewControllerAnimated:YES];
    
    UIButton* bt = sender;
    [popOverCtrl presentPopoverFromRect:CGRectMake(bt.frame.origin.x-100, 0, 100, 100 ) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:TRUE];
    
    // [popOverCtrl presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:TRUE];
}

- (IBAction) HitCertify:(id)sender{
    CertifyViewController* detailViewCtrl = [[CertifyViewController alloc] initWithNibName:@"CertifyViewController" bundle:nil];
    
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
    
    
    [detailViewCtrl release];
}

- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"pop over dismiss");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Product evaluation request";
    
    //Create Button
    UIBarButtonItem* cancelbt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Cancel)];
    
    [self.navigationItem setLeftBarButtonItem:cancelbt animated:YES];
    [cancelbt release];
    
    UIBarButtonItem* donebt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Done)];
    
    [self.navigationItem setRightBarButtonItem:donebt animated:YES];
    [donebt release];
    
    //Init data
    dicData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProductEvaluationRequest" ofType:@"plist"]];
    
    
    keys = [[NSArray alloc] initWithObjects:@"Evaluation request", @"Entry", nil];
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[dicData objectForKey:[keys objectAtIndex:section]] count];
}

- (NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 5;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [keys objectAtIndex:section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 1 && [indexPath row] == 0) {
        return 80;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSInteger sec = [indexPath section];
    NSString* header = [keys objectAtIndex:sec];
    NSArray* array = [dicData objectForKey:header];
    
    if ([indexPath section] == 0) {
        
        static NSString *CellIdentifier = @"CellProperty";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            //*
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
            /*/[[NSBundle mainBundle] loadNibNamed:@"TableCell_Property" owner:self options:nil];
             
             cell = cellProperty;
             self.cellProperty = nil;
             **/
        }
        
        // Configure the cell...
        
        
        //*
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.detailTextLabel.text = @"data";
        /*/
         
         ((UILabel*)[cell viewWithTag:1]).text = [array objectAtIndex:[indexPath row]];
         ((UILabel*)[cell viewWithTag:2]).text = [array objectAtIndex:[indexPath row]];
         **/
    }
    else{
        
        if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            
            static NSString *CellIdentifier1 = @"CellHeader";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                //*
                //UINib* a = [[UINib alloc] nibWithNibName:@"TableCell_Header" bundle:nil];
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_Product" owner:self options:nil];
                cell = cellHeader;
                
                self.cellHeader = nil;
            }
        }else if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_Data"]){
            static NSString *CellIdentifier2 = @"CellData";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) {
                //*
                //UINib* a = [[UINib alloc] nibWithNibName:@"TableCell_Header" bundle:nil];
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_Product" owner:self options:nil];
                cell = cell6Column;
                
                self.cell6Column = nil;
            }
        }
    }
    
    return cell;
}


// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }*/



// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}



// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] > 0) {
        if (!popOverCtrl) {
            ProductAddDetailPopupVCTRL* viewCtrl = [[ProductAddDetailPopupVCTRL alloc] initWithNibName:@"ProductAddDetailPopupVCTRL" bundle:nil];
            
            UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
            
            popOverCtrl = [[UIPopoverController alloc] initWithContentViewController:navi];
            [popOverCtrl setDelegate:self];
            
            [viewCtrl setParentPopup:popOverCtrl];
            
            [viewCtrl release];
            [navi release];
        }
        
        [((UINavigationController*)popOverCtrl.contentViewController) popToRootViewControllerAnimated:YES];
        
        [popOverCtrl presentPopoverFromRect:CGRectMake(tableView.frame.origin.x, 200, 500, 500 ) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:TRUE];
        
        // [popOverCtrl presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:TRUE];
    }
}


@end
