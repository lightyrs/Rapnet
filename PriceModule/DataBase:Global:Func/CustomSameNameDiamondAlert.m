//
//  CustomSameNameDiamondAlert.m
//  RapnetPriceModule
//
//  Created by Nikhil Bansal on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomSameNameDiamondAlert.h"


@implementation CustomSameNameDiamondAlert

@synthesize oldBtn,currentBtn,msgLbl,delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [msgLbl release];
	[oldBtn release];
	[currentBtn release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)oldBtn:(id)sender{
    
    self.view.hidden =YES;
    [delegate alertSameNameDiamondFinished:1];
}

-(IBAction)currentBtn:(id)sender{
    self.view.hidden =YES;
    [delegate alertSameNameDiamondFinished:2];
}

-(void)setMsg:(NSString *)str{
    self.msgLbl.text = str;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
