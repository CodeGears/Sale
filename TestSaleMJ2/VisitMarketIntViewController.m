//
//  VisitMarketIntViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VisitMarketIntViewController.h"


@implementation VisitMarketIntViewController

@synthesize cellBroweImage;

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

- (IBAction) BroweImage:(id)sender{
    
}

- (IBAction) DeleteImage:(id)sender{
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Order";
    
    //Create Button
    UIBarButtonItem* cancelbt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Cancel)];
    
    [self.navigationItem setLeftBarButtonItem:cancelbt animated:YES];
    [cancelbt release];
    
    UIBarButtonItem* donebt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(Done)];
    
    [self.navigationItem setRightBarButtonItem:donebt animated:YES];
    [donebt release];
    
    //Init data
    dicData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MarketIntelligence" ofType:@"plist"]];
    
    
    keys = [[NSArray alloc] initWithObjects:@"Market intelligence", @"Photo", nil];
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        return 44;
    }else{
        return 268;
    }
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
        
        if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_photo"]) {
            
            static NSString *CellIdentifier1 = @"CellPhoto";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                //*
                //UINib* a = [[UINib alloc] nibWithNibName:@"TableCell_Header" bundle:nil];
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_Market" owner:self options:nil];
                cell = cellBroweImage;
                
                self.cellBroweImage = nil;
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

@end
