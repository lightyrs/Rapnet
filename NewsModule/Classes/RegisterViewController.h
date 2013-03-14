//
//  RegisterViewController.h
//  Rapnet
//
//  Created by Richa on 6/6/11.
//  Copyright 2011 TechAhead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "AppDelegate.h"
#import "CountryListController.h"

@interface RegisterViewController : UIViewController
{
	IBOutlet UITextField *txtCountry;
	IBOutlet UITextField *txtSignUp;
	IBOutlet UIImageView *imgCountry;
	IBOutlet UIImageView *imgSignUp;
	IBOutlet UILabel *lblCountry;
	
}

-(IBAction)joinBtn;
-(IBAction)bckBtn;
-(IBAction)countryList;

@end
