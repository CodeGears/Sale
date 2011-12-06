//
//  SyncViewController.m
//  TestSaleMJ2
//
//  Created by Jarruspong Makkul on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SyncViewController.h"

@implementation SyncViewController
@synthesize cacheDB;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    // Do any additional setup after loading the view from its nib.
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

#
-(IBAction)showActionSheet:(id)sender {
	UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Synchronize" 
                                                            delegate:self 
                                                   cancelButtonTitle:@"Cancel Button" 
                                              destructiveButtonTitle:@"Retrieve All data" 
                                                   otherButtonTitles:@"Transfer To Server", @"Retrieve Data", @"Transfer and Retrieve Data", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
	[popupQuery release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    selectedSyncMode = buttonIndex;
	if (buttonIndex == 0) {
		//Retrieve All data
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        HUD.delegate = self;
        HUD.labelText = @"Syncing...";
        
        [HUD show:YES];
        
        TestSaleMJ2AppDelegate *delegate = (TestSaleMJ2AppDelegate *)[[UIApplication sharedApplication] delegate];
        self.cacheDB = delegate.cacheDB;
        self.cacheDB.delegate = self;
        
        //initalize download service call
        [self.cacheDB initDownloadMyDataset:@"301494"];
	}
}

#pragma mark -
#pragma mark CacheDBCommands Delegate

- (void)willStartDownloading:(CacheDBCommands *)cacheDB
{
	//NSLog(@"Delegate called start downloading", nil);
    
	
}
-(void)didFinishDownloading:(CacheDBCommands *)acacheDB
{
    if (selectedSyncMode == 0) { //Retrieve All data
        
        //delete all data
        FMDatabase *database = [FMDatabase databaseWithPath: [[MJUtility sharedInstance] getDBPath]]; 
        
        if (![database open]) {
            [database release];
            return;
        }
        
        //fetch data
        NSArray *allTableNames = [self.cacheDB.myDataset.Tables allKeys];
        NSString *tableName;
        for (tableName in allTableNames) {
            NSLog(@"<%@>", tableName);
            
            [database executeQueryWithFormat:@"DELETE FROM %@", tableName];
            
            NSMutableDictionary *rows = [[NSMutableDictionary alloc] initWithDictionary:[self.cacheDB.myDataset getRowsForTable:tableName]];
            NSMutableArray *callData = (NSMutableArray *)[NSMutableArray arrayWithArray:[rows allValues]];
            
            NSEnumerator *cdenum = [callData objectEnumerator];
            NSDictionary *row;
            while (row = [cdenum nextObject]) {
                NSArray *allFieldsNames = [row allKeys];
                NSString *fieldName;
                for (fieldName in allFieldsNames) {
                    if (![(NSString *)[row objectForKey:fieldName] isEqual:@""] && ![(NSString *)[row objectForKey:fieldName] isEqual:@"(null)"]) {
                        NSLog(@"%@ : %@", fieldName, (NSString *)[row objectForKey:fieldName]);
                        
                        //[database executeQueryWithFormat:@"DELETE FROM %@", tableName];
                        [database executeUpdateWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)", tableName, fieldName, (NSString *)[row objectForKey:fieldName]];
                    }
                }
                NSLog(@"->");
            }
        }
        
        [database close];
        [HUD hide:YES afterDelay:0.0];
        
        //test
    }

}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

@end
