//
//  SellHistoryViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SellHistoryViewController.h"


@implementation SellHistoryViewController

@synthesize cellInvoiceColumn, cellInvoiceHeader, cellBackOrderColumn,cellBackOrderHeader;

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
    
    [dicData release];
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

    //Init data
    dicData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SalesHistory" ofType:@"plist"]];
    
    
    keys = [[NSArray alloc] initWithObjects:@"Invoice", @"Back order", nil];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSInteger sec = [indexPath section];
    NSString* header = [keys objectAtIndex:sec];
    NSArray* array = [dicData objectForKey:header];
    
    
    if ([indexPath section] == 0) {
        if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            
            static NSString *CellIdentifier1 = @"CellHeader";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_SalesHistory" owner:self options:nil];
                cell = cellInvoiceHeader;
                
                self.cellInvoiceHeader = nil;
            }
        }else if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_Data"]){
            static NSString *CellIdentifier2 = @"CellData";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_SalesHistory" owner:self options:nil];
                cell = cellInvoiceColumn;
                
                self.cellInvoiceColumn = nil;
            }
        }
    }else{
        if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            
            static NSString *CellIdentifier1 = @"CellHeader2";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_SalesHistory" owner:self options:nil];
                cell = cellBackOrderHeader;
                
                self.cellBackOrderHeader = nil;
            }
        }else if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_Data"]){
            static NSString *CellIdentifier2 = @"CellData2";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_SalesHistory" owner:self options:nil];
                cell = cellBackOrderColumn;
                
                self.cellBackOrderColumn = nil;
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
//
//
//
//// Override to support conditional rearranging of the table view.
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

@end
