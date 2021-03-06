//
//  ActivityAlertView.m
//  PositionApp
//
//  Created by Riyaz Ahemad on 09/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityAlertView.h"


@implementation ActivityAlertView

@synthesize activityView;

-(id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
        activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(210, 18, 20, 20)];
		[self addSubview:activityView];
		activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
		[activityView startAnimating];
    }
	
    return self;
}


-(void)close
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)dealloc
{
	[activityView release];
	[super dealloc];
}

@end
