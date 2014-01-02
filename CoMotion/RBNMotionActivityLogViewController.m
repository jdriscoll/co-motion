//
//  RBNMotionActivityLogViewController.m
//  CoMotion
//
//  Created by Justin Driscoll on 1/2/14.
//  Copyright (c) 2014 Retrobit, LLC. All rights reserved.
//

#import "RBNMotionActivityLogViewController.h"

@interface RBNMotionActivityLogViewController ()
@property (nonatomic, weak) IBOutlet UITextView *textView;
@end

@implementation RBNMotionActivityLogViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textView.text = @"";
}

-  (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.activityManager) {
        __weak UITextView *textView = self.textView;
        [self.activityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue]
                                              withHandler:^(CMMotionActivity *activity) {
                                                  textView.text = [NSString stringWithFormat:@"%@\n\n%@", activity, textView.text];
                                              }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.activityManager) {
        [self.activityManager stopActivityUpdates];
    }
}


@end
