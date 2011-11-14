//
//  ProductAddPopupVCTRL.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProductAddPopupVCTRL : UITableViewController 
<UINavigationControllerDelegate>
{
    NSArray* keys;
    
    UIPopoverController* parentPopup;
}

@property (nonatomic, assign) UIPopoverController* parentPopup;


@end
