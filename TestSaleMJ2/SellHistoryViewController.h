//
//  SellHistoryViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SellHistoryViewController : UITableViewController < UIPopoverControllerDelegate, UINavigationControllerDelegate> 
{
    NSDictionary* dicData;
    NSArray*    keys;
    
    UITableViewCell* cellInvoiceHeader;
    UITableViewCell* cellInvoiceColumn;
    
    UITableViewCell* cellBackOrderHeader;
    UITableViewCell* cellBackOrderColumn;
}

@property (nonatomic, assign) IBOutlet UITableViewCell* cellInvoiceHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellInvoiceColumn;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellBackOrderHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellBackOrderColumn;


@end
