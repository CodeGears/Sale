//
//  SyncViewController.h
//  TestSaleMJ2
//
//  Created by Jarruspong Makkul on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheDBCommands.h"
#import "TestSaleMJ2AppDelegate.h"

#import "MJUtility.h"
#import "FMDatabase.h"
#import "MBProgressHUD.h"

@interface SyncViewController : UIViewController <UIActionSheetDelegate, CacheDBDelegate, MBProgressHUDDelegate> {
    int selectedSyncMode;
    MBProgressHUD *HUD;
}

@property (nonatomic, retain) CacheDBCommands *cacheDB;

@end
