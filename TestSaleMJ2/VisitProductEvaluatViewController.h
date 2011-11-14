//
//  VisitProductEvaluatViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VisitProductEvaluatViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource,UIPopoverControllerDelegate, UINavigationControllerDelegate> 
{
    UIPopoverController* popOverCtrl;
    UIPopoverController* editPopOverCtrl;
    
    NSDictionary* dicData;
    NSArray*    keys;
    
    UITableViewCell* cellProperty;
    UITableViewCell* cellHeader;
    UITableViewCell* cell6Column;
}

@property (nonatomic, assign) IBOutlet UITableViewCell* cellProperty;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cell6Column;

-(IBAction) HitPopup:(id)sender; 
-(IBAction) HitCertify:(id)sender;

@end
