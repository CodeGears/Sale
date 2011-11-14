//
//  VisitMarketIntViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VisitMarketIntViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource,UIPopoverControllerDelegate, UINavigationControllerDelegate> 
{

    UIPopoverController* popOverCtrl;
    
    NSDictionary* dicData;
    NSArray*    keys;
    
    UITableViewCell* cellBroweImage;
}

@property (nonatomic, assign) IBOutlet UITableViewCell* cellBroweImage;

-(IBAction) BroweImage:(id)sender;
-(IBAction) DeleteImage:(id)sender;

@end
