//
//  VisitMarketSurveyViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VisitMarketSurveyViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,UIPopoverControllerDelegate, UINavigationControllerDelegate>
{
    UIPopoverController* popOverCtrl;
    
    NSDictionary* dicData;
    NSArray*    keys;
    
    UITableViewCell* cellHeader;
    UITableViewCell* cell4Column;
    
}

@property (nonatomic, assign) IBOutlet UITableViewCell* cellHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cell4Column;

@end
