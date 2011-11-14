//
//  CertifyViewController.h
//  TestSaleMJ2
//
//  Created by Theprit Anongchanya on 10/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CertifyViewController : UIViewController {
    
    IBOutlet UITextView* textview;
    IBOutlet UIImageView* signImgView;
    IBOutlet UILabel*     dateLbl;
}

- (IBAction) HitCancel:(id)sender;
- (IBAction) HitClear:(id)sender;
- (IBAction) HitDone:(id)sender;

@end
