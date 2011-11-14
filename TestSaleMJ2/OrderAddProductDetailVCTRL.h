//
//  OrderAddProductDetailVCTRL.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OrderAddProductDetailVCTRL : UITableViewController
<UINavigationControllerDelegate>
{
    NSArray* keys;
    
    UIPopoverController* parentPopup;
}

- (IBAction) HitDone:(id)sender;

@property (nonatomic, assign) UIPopoverController* parentPopup;


@end
