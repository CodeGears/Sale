//
//  RootViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class NewCustomerViewController;

@interface RootViewController : UIViewController <UITableViewDelegate, UINavigationBarDelegate, UITabBarDelegate, UIPopoverControllerDelegate>{

    DetailViewController* detailView;
    NewCustomerViewController* createNewViewCtrl;
    
    UIPopoverController* popOverCtrl;
    
    NSArray* localNameKeys;
    NSArray* localNameList;
}


- (IBAction) CreatePopOverController:(id)sender;
- (IBAction) CreateNewView:(id)sender;



@property (nonatomic, retain) IBOutlet UITableView*     tableView;
@property (nonatomic, retain) IBOutlet UITabBar*        tabBar;
@property (nonatomic, retain) IBOutlet UINavigationBar* naviBar;


@property (nonatomic, retain) DetailViewController* detailView;

- (void) SetOwnDetailView:(DetailViewController*)view;

@end
