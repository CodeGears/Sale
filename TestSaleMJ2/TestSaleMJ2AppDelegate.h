//
//  TestSaleMJ2AppDelegate.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheDBCommands.h"

//@class RootViewController;

//@class DetailViewController;

@interface TestSaleMJ2AppDelegate : NSObject <UIApplicationDelegate, UISplitViewControllerDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) CacheDBCommands *cacheDB;
//@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;

//@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

//@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@end
