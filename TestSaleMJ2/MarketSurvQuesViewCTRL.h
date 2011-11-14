//
//  MarketSurvQuesViewCTRL.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MarketSurvQuesViewCTRL : UIViewController
< UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate> 
{
    IBOutlet UILabel* titleLbl;
    IBOutlet UITextField* questionTextField;
    
    IBOutlet UITextView* answerTextView;
    IBOutlet UITableView* answerTableView;
}

- (IBAction) HitNext:(id)sender;
- (IBAction) HitCancel:(id)sender;
- (IBAction) HitDone:(id)sender;

@end
