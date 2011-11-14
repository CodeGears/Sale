//
//  VisitRecordCallViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VisitRecordCallViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource,UIPopoverControllerDelegate, UINavigationControllerDelegate>
{
    NSDictionary* dicData;
    NSArray*    keys;
}

@end
