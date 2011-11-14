//
//  CustomerDetailViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewCustomerViewController;
@class NewWorkplaceViewController;
@class NewChildViewController;
@class NewHobbyViewController;

@interface CustomerDetailViewController : UITableViewController<UIScrollViewDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate> {
    
    NewCustomerViewController*  newCustomerViewCtrl;
    NewWorkplaceViewController* newWorkPlaceViewCtrl;
    NewChildViewController*     newChildViewCtrl;
    NewHobbyViewController*     newHobbyViewCtrl;
    
    UINavigationController* parentNavigator;
    
    UIPopoverController* visitPopOverCtrl;

    NSDictionary* dicData;
    NSArray*    keys;
    
    UITableViewCell* cellPortaitInfo;
    UITableViewCell* cellMapGPS;
    
    //UITableViewCell* cellCheckList;
    
    UITableViewCell* cellChildInfoHeader;
    UITableViewCell* cellChildInfoDetail;
    
    UITableViewCell* cellHobbyInfoHeader;
    UITableViewCell* cellHobbyInfoDetail;
    
    UITableViewCell* cellMemberInfoHeader;
    UITableViewCell* cellMemberInfoDetail;
    
    UITableViewCell* cellWorkplaceInfoHeader;
    UITableViewCell* cellWorkplaceInfoDetail;
    
    UITableViewCell* cellCustomerPatientInfoHeader;
    UITableViewCell* cellCustomerPatientInfoDetail;
    
    UITableViewCell* cellProductRecInfoHeader;
    UITableViewCell* cellProductRecInfoDetail;
}

@property (nonatomic, assign) IBOutlet UITableViewCell* cellPortaitInfo;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellMapGPS;

@property (nonatomic, assign) IBOutlet UITableViewCell* cellChildInfoHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellChildInfoDetail;

@property (nonatomic, assign) IBOutlet UITableViewCell* cellHobbyInfoHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellHobbyInfoDetail;

@property (nonatomic, assign) IBOutlet UITableViewCell* cellMemberInfoHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellMemberInfoDetail;

@property (nonatomic, assign) IBOutlet UITableViewCell* cellWorkplaceInfoHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellWorkplaceInfoDetail;

@property (nonatomic, assign) IBOutlet UITableViewCell* cellCustomerPatientInfoHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellCustomerPatientInfoDetail;

@property (nonatomic, assign) IBOutlet UITableViewCell* cellProductRecInfoHeader;
@property (nonatomic, assign) IBOutlet UITableViewCell* cellProductRecInfoDetail;


- (void) SetParentNavigator:(UINavigationController*)navi;

- (IBAction) CreateVisitPopOverController:(id)sender;

- (IBAction) HitNewHobbyBt;
- (IBAction) HitEditHobbyBt;

- (IBAction) HitNewChildBt;
- (IBAction) HitEditChildBt;

- (IBAction) HitNewWorkPlaceBt;
- (IBAction) HitEditWorkPlaceBt;

@end
