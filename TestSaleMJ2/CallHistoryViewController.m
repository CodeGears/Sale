//
//  CallHistoryViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CallHistoryViewController.h"
#import "CallHistoryDetailViewController.h"

@implementation CallHistoryViewController

@synthesize cellHeader,cell4Column;

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
    [parentNavigator release];
    [dicData release];
    [keys release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) SetParentNavigator:(UINavigationController *)navi{
    parentNavigator = [navi retain];
}

#pragma mark - IBAction Handle

- (IBAction) HitCallHistoryBt{
    
    
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
    
    //self.title = @"Order";
    
    //Init data
    dicData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CallHistoryTab" ofType:@"plist"]];
    
    
    keys = [[NSArray alloc] initWithObjects:@"Call history", nil];
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
    
   
        
    if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
        
        static NSString *CellIdentifier1 = @"CellHeader";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"TableCell_CallHistory" owner:self options:nil];
            cell = cellHeader;
            
            self.cellHeader = nil;
        }
    }else if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_Data"]){
        static NSString *CellIdentifier2 = @"CellData";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"TableCell_CallHistory" owner:self options:nil];
            cell = cell4Column;
            
            self.cell4Column = nil;
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
    CallHistoryDetailViewController* v = [[CallHistoryDetailViewController alloc] initWithNibName:@"CallHistoryDetail" bundle:nil];
    [v setTitle:@"CallHistory Detail"];
    
    [parentNavigator pushViewController:v animated:true];
    [v release];
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CallHistoryDetailViewController* v = [[CallHistoryDetailViewController alloc] initWithNibName:@"CallHistoryDetail" bundle:nil];
    [v setTitle:@"CallHistory Detail"];
    
    [parentNavigator pushViewController:v animated:true];
    [v release];
}

@end
