//
//  CustomerDetailViewController.m
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomerDetailViewController.h"

#import "VisitCustomerDetailPopupVCTRL.h"

#import "CustomerTypePopoverViewCTRL.h"
#import "NewCustomerViewController.h"

#import "NewWorkplaceViewController.h"
#import "NewChildViewController.h"
#import "NewHobbyViewController.h"

#import "HobbyDetailViewController.h"
#import "ChildDetailViewController.h"
#import "WorkPlaceDetailEditViewController.h"

#import "CustomerDataManager.h"

@implementation CustomerDetailViewController

@synthesize cellMapGPS, cellPortaitInfo;
@synthesize cellChildInfoDetail, cellChildInfoHeader;
@synthesize cellHobbyInfoDetail, cellHobbyInfoHeader;
@synthesize cellMemberInfoDetail, cellMemberInfoHeader;
@synthesize cellWorkplaceInfoDetail, cellWorkplaceInfoHeader;
@synthesize cellProductRecInfoDetail, cellProductRecInfoHeader;
@synthesize cellCustomerPatientInfoDetail, cellCustomerPatientInfoHeader;

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
    [newCustomerViewCtrl release];
    [newWorkPlaceViewCtrl release];
    [newChildViewCtrl release];
    [newHobbyViewCtrl release];
    [visitPopOverCtrl release];
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

#pragma mark - POPOver Handle
- (IBAction) CreateVisitPopOverController:(id)sender{
    
   
    
    if (!visitPopOverCtrl) {
         VisitCustomerDetailPopupVCTRL* viewCtrl = [[VisitCustomerDetailPopupVCTRL alloc] initWithNibName:@"VisitCustomerDetailPopupVCTRL" bundle:nil];
         //UIViewController* viewCtrl = [[UIViewController alloc] init];
        
        visitPopOverCtrl = [[UIPopoverController alloc] initWithContentViewController:viewCtrl];
        [visitPopOverCtrl setDelegate:self];
        
        [viewCtrl setParentPopup:visitPopOverCtrl];
        [viewCtrl release];
    }
    
    [visitPopOverCtrl presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:TRUE];
    
}
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"pop over dismiss");
}

#pragma mark - IBAction Handle

- (IBAction) HitNewHobbyBt{
    if (!newHobbyViewCtrl) {
        newHobbyViewCtrl = [[NewHobbyViewController alloc] initWithNibName:@"NewHobby" bundle:nil];
    }
    
    //[viewCtrl setModalInPopover:TRUE];
    [newHobbyViewCtrl setModalPresentationStyle:UIModalPresentationFormSheet];
    [newHobbyViewCtrl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    
    [self presentModalViewController:newHobbyViewCtrl animated:YES];
}

- (IBAction) HitEditHobbyBt{
    HobbyDetailViewController* v = [[HobbyDetailViewController alloc] initWithNibName:@"HobbyDetail" bundle:nil];
    [v setTitle:@"Hobby Detail"];
    
    [parentNavigator pushViewController:v animated:true];
    [v release];
}

- (IBAction) HitNewChildBt{
    if (!newChildViewCtrl) {
        newChildViewCtrl = [[NewChildViewController alloc] initWithNibName:@"NewChild" bundle:nil];
    }
    
    //[viewCtrl setModalInPopover:TRUE];
    [newChildViewCtrl setModalPresentationStyle:UIModalPresentationFormSheet];
    [newChildViewCtrl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    
    [self presentModalViewController:newChildViewCtrl animated:YES];
}

- (IBAction) HitEditChildBt{
    ChildDetailViewController* v = [[ChildDetailViewController alloc] initWithNibName:@"ChildDetail" bundle:nil];
    [v setTitle:@"Child Detail"];
    
    [parentNavigator pushViewController:v animated:true];
    [v release];
}

- (IBAction) HitNewWorkPlaceBt{
    if (!newWorkPlaceViewCtrl) {
        newWorkPlaceViewCtrl = [[NewWorkplaceViewController alloc] initWithNibName:@"NewWorkPlace" bundle:nil];
    }
    
    //[viewCtrl setModalInPopover:TRUE];
    [newWorkPlaceViewCtrl setModalPresentationStyle:UIModalPresentationFormSheet];
    [newWorkPlaceViewCtrl setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    
    
    [self presentModalViewController:newWorkPlaceViewCtrl animated:YES];
}

- (IBAction) HitEditWorkPlaceBt{
    WorkPlaceDetailEditViewController* v = [[WorkPlaceDetailEditViewController alloc] initWithNibName:@"WorkplaceDetail" bundle:nil];
    
    [v setTitle:@"Workplace Detail"];
    
    [parentNavigator pushViewController:v animated:true];
    [v release];
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
    
    //Init data
    dicData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CustomerDetail" ofType:@"plist"]];
    
    
    keys = [[NSArray alloc] initWithObjects:@"Customer Detail", @"System Info", @"Personal Info", @"Location", @"Education Info", @"Family Info", @"Child Info", @"Hobby Info", @"Member Detail", @"Home", @"Clinic", @"Workplace Detail", @"Business", @"Customer Patient", @"Product Recommendation", @"Status", @"SES", nil];
    
    //Create Button
//    UIBarButtonItem* cancelbt = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Cancel)];
//    
//    [self.navigationItem setLeftBarButtonItem:cancelbt animated:YES];
//    [cancelbt release];
    
    UIBarButtonItem* visitbt = [[UIBarButtonItem alloc] initWithTitle:@"Visit" style:UIBarButtonItemStyleBordered target:self action:@selector(CreateVisitPopOverController:)];
    
    [self.navigationItem setRightBarButtonItem:visitbt animated:YES];
    [visitbt release];
    
    self.title = [[CustomerDataManager sharedInstance] GetCustomerDetailName:@""];
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
    
    //Child count + header
    if ([[keys objectAtIndex:section] isEqualToString:@"Child Info"] ) {
        return [[CustomerDataManager sharedInstance] GetCustomerDetailChildCount:@""]+1;
    }
    //hobby
    else if ([[keys objectAtIndex:section] isEqualToString:@"Hobby Info"] ) {
        return [[CustomerDataManager sharedInstance] GetCustomerDetailHobbyInfoCount:@""]+1;
    }
    //memberDetail
    else if ([[keys objectAtIndex:section] isEqualToString:@"Member Detail"] ) {
        return [[CustomerDataManager sharedInstance] GetCustomerDetailMemberDetailCount:@""]+1;
    }
    //Workplace
    else if ([[keys objectAtIndex:section] isEqualToString:@"Workplace Detail"] ) {
        return [[CustomerDataManager sharedInstance] GetCustomerDetailWorkplaceDetailCount:@""]+1;
    }
    else{
            
        return [[dicData objectForKey:[keys objectAtIndex:section]] count];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) { //Protait
        return 180;
    }
    else if([indexPath section] == 3 && [indexPath row]==2){ //Map
        return 331;
    }
    else{
        return 44;
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
    
    if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Customer Detail"] ) {
        
        if (cell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
            cell = cellPortaitInfo;
            
            self.cellPortaitInfo = nil;
        }
        
        ((UILabel*)[cell viewWithTag:1]).text = [[CustomerDataManager sharedInstance] GetCustomerDetailName:@""];
        ((UILabel*)[cell viewWithTag:2]).text = [[CustomerDataManager sharedInstance] GetCustomerWorkName:@""];
        //((UIImage*)[cell viewWithTag:3]);
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"System Info"] ) {
        
        static NSString *CellIdentifier = @"CellProperty";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        cell.detailTextLabel.text = [[[CustomerDataManager sharedInstance] GetCustomerDetailSystemInfo:@""] objectAtIndex:[indexPath row]];
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Personal Info"] ) {
        
        static NSString *CellIdentifier = @"CellProperty";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        cell.detailTextLabel.text = [[[CustomerDataManager sharedInstance] GetCustomerDetailPersonalInfo:@""] objectAtIndex:[indexPath row]];
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Location"] ) {
        
        if ([[array objectAtIndex:[indexPath row]] isEqualToString:@"_MapGPS"]) {
            
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellMapGPS;
                
                self.cellMapGPS = nil;
            }
            
            ((UILabel*)[cell viewWithTag:2]).text = [[[CustomerDataManager sharedInstance] GetCustomerDetailLocation:@""] objectAtIndex:[indexPath row]];
        }
        else{
            static NSString *CellIdentifier = @"CellProperty";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
            }
            
            // Configure the cell...
            cell.textLabel.text = [array objectAtIndex:[indexPath row]];
            cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
            cell.detailTextLabel.text = [[[CustomerDataManager sharedInstance] GetCustomerDetailLocation:@""] objectAtIndex:[indexPath row]];
        }
        
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Education Info"] ) {
        
        static NSString *CellIdentifier = @"CellProperty";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        cell.detailTextLabel.text = [[[CustomerDataManager sharedInstance] GetCustomerDetailEducationInfo:@""] objectAtIndex:[indexPath row]];
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Family Info"] ) {
        
        static NSString *CellIdentifier = @"CellProperty";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        cell.detailTextLabel.text = [[[CustomerDataManager sharedInstance] GetCustomerDetailFamilyInfo:@""] objectAtIndex:[indexPath row]];
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Child Info"] ) {
        
        if ([indexPath row]== 0 && [[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellChildInfoHeader;
                
                self.cellChildInfoHeader = nil;
            }
        }
        else{
            static NSString *CellIdentifier1 = @"CellPropertyAccEdit";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1] autorelease];
            }
            
            // Configure the cell...
            NSArray* childData = [[[CustomerDataManager sharedInstance] GetCustomerDetailChildInfo:@""] objectAtIndex:[indexPath row]-1];
            
            cell.textLabel.text = [childData objectAtIndex:0];
            cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
            cell.detailTextLabel.text = [childData objectAtIndex:1];

            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            cell.editing = TRUE;
        }
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Hobby Info"] ) {
        
        if ([indexPath row]== 0 && [[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellHobbyInfoHeader;
                
                self.cellHobbyInfoHeader = nil;
            }
        }
        else{
            static NSString *CellIdentifier1 = @"CellPropertyAccEdit";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1] autorelease];
            }
            
            // Configure the cell...
            NSArray* hobbyData = [[[CustomerDataManager sharedInstance] GetCustomerDetailHobbyInfo:@""] objectAtIndex:[indexPath row]-1];
            
            cell.textLabel.text = [hobbyData objectAtIndex:0];
            cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
            cell.detailTextLabel.text =[hobbyData objectAtIndex:1];
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            cell.editing = TRUE;
        }
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Member Detail"] ) {
        
        static NSString *CellIdentifier4 = @"cellMemberHeader";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        
        if ([indexPath row]== 0 && [[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellMemberInfoHeader;
                
                self.cellMemberInfoHeader = nil;
            }
        }
        else{
            
            static NSString *CellIdentifier4 = @"cellMemberDetail";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellMemberInfoDetail;
                
                self.cellMemberInfoDetail = nil;
                
                NSArray* memberData = [[[CustomerDataManager sharedInstance] GetCustomerDetailMemberDetail:@""] objectAtIndex:[indexPath row]-1];
                
                ((UILabel*)[cell viewWithTag:1]).text = [memberData objectAtIndex:0];
                ((UILabel*)[cell viewWithTag:2]).text = [memberData objectAtIndex:1];
                ((UILabel*)[cell viewWithTag:3]).text = [memberData objectAtIndex:2];
                ((UILabel*)[cell viewWithTag:4]).text = [memberData objectAtIndex:3];
                ((UILabel*)[cell viewWithTag:5]).text = [memberData objectAtIndex:4];
            }
        }
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Home"] ) {
        
        static NSString *CellIdentifier = @"CellProperty";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        cell.detailTextLabel.text = [[[CustomerDataManager sharedInstance] GetCustomerDetailHomeInfo:@""] objectAtIndex:[indexPath row]];
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Clinic"] ) {
        
        static NSString *CellIdentifier = @"CellProperty";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        cell.detailTextLabel.text = [[[CustomerDataManager sharedInstance] GetCustomerDetailClinicInfo:@""] objectAtIndex:[indexPath row]];
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Workplace Detail"] ) {
        
        static NSString *CellIdentifier4 = @"cellWorkPlaceHeader";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        
        if ([indexPath row]== 0 && [[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellWorkplaceInfoHeader;
                
                self.cellWorkplaceInfoHeader = nil;
            }
        }
        else{
            static NSString *CellIdentifier = @"CellPropertyAccEdit";
            
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            }
            
            // Configure the cell...
            NSArray* workplaceData = [[[CustomerDataManager sharedInstance] GetCustomerDetailMemberDetail:@""] objectAtIndex:[indexPath row]-1];
            
           
            cell.textLabel.text = [workplaceData objectAtIndex:0];
            cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
            cell.detailTextLabel.text = [workplaceData objectAtIndex:1];
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            cell.editing = TRUE;
        }
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Business"] ) {
        
        static NSString *CellIdentifier3 = @"CellPropertyCheck";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        
        if ([[[[CustomerDataManager sharedInstance] GetCustomerDetailBussinessDetail:@""] objectAtIndex:[indexPath row]] isEqualToString:@"yes"]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Customer Patient"] ) {
        
        if ([indexPath row]== 0 && [[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            static NSString *CellIdentifier4 = @"cellCustPatientHeader";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellCustomerPatientInfoHeader;
                
                self.cellCustomerPatientInfoHeader = nil;
            }
        }
        else{
            static NSString *CellIdentifier4 = @"cellCustPatientDetail";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellCustomerPatientInfoDetail;
                
                self.cellCustomerPatientInfoDetail = nil;
                
                
                NSArray* patientData = [[[CustomerDataManager sharedInstance] GetCustomerDetailCustomerPatient:@""] objectAtIndex:[indexPath row]-1];
                
                ((UILabel*)[cell viewWithTag:1]).text = [patientData objectAtIndex:0];
                ((UILabel*)[cell viewWithTag:2]).text = [patientData objectAtIndex:1];
                ((UILabel*)[cell viewWithTag:3]).text = [patientData objectAtIndex:2];
            }
        }
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Product Recommendation"] ) {
        
        if ([indexPath row]== 0 && [[array objectAtIndex:[indexPath row]] isEqualToString:@"_Header"]) {
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellProductRecInfoHeader;
                
                self.cellProductRecInfoHeader = nil;
            }
        }
        else{
            
            static NSString *CellIdentifier4 = @"cellProductDetail";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            
            if (cell == nil) {
                [[NSBundle mainBundle] loadNibNamed:@"TableCell_CustomerDetail" owner:self options:nil];
                cell = cellProductRecInfoDetail;
                
                self.cellProductRecInfoDetail = nil;
                
                NSArray* productData = [[[CustomerDataManager sharedInstance] GetCustomerDetailProductRecommend:@""] objectAtIndex:[indexPath row]-1];
                
                ((UILabel*)[cell viewWithTag:1]).text = [productData objectAtIndex:0];
                ((UILabel*)[cell viewWithTag:2]).text = [productData objectAtIndex:1];
            }
        }
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"Status"] ) {
        
        static NSString *CellIdentifier3 = @"CellPropertyCheck";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        
        if ([[[[CustomerDataManager sharedInstance] GetCustomerDetailStatus:@""] objectAtIndex:[indexPath row]] isEqualToString:@"yes"]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if ( [[keys objectAtIndex:[indexPath section]] isEqualToString:@"SES"] ) {
        
        static NSString *CellIdentifier3 = @"CellPropertyCheck";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        
        if ([[[[CustomerDataManager sharedInstance] GetCustomerDetailSES:@""] objectAtIndex:[indexPath row]] isEqualToString:@"yes"]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else{
        
        static NSString *CellIdentifier = @"CellProperty";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array objectAtIndex:[indexPath row]];
        cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
        cell.detailTextLabel.text = @"data";
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
    if([[keys objectAtIndex:[indexPath section]] isEqualToString:@"Child Info"]){
        [self HitEditChildBt];
    }
    else if([[keys objectAtIndex:[indexPath section]] isEqualToString:@"Hobby Info"]){
        [self HitEditHobbyBt];
    }
    else if([[keys objectAtIndex:[indexPath section]] isEqualToString:@"Workplace Detail"]){
        [self HitEditWorkPlaceBt];
    }
}

@end
