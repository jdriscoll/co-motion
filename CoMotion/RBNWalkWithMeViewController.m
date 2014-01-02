//
//  RBNWalkWithMeViewController.m
//  CoMotion
//
//  Created by Brian Cooke on 1/2/14.
//  Copyright (c) 2014 Retrobit, LLC. All rights reserved.
//

#import "RBNWalkWithMeViewController.h"

@interface RBNWalkWithMeViewController ()

@property (strong, nonatomic) CMStepCounter *stepCounter;
@property (weak, nonatomic) IBOutlet UILabel *stepCountLabel;

@end

@implementation RBNWalkWithMeViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.title = @"Fire Walk With Me";

    if ([CMStepCounter isStepCountingAvailable] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"I can't see your steps!?"
                                                       delegate:nil
                                              cancelButtonTitle:@":'("
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.stepCounter = [[CMStepCounter alloc] init];

    self.stepCountLabel.text = @"0 steps";

    __weak typeof(self) weakSelf = self;
    [self.stepCounter startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:1 withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
        weakSelf.stepCountLabel.text = [NSString stringWithFormat:@"%ld steps", (long)numberOfSteps];
    }];
    // counting auto-stops when dealloc'd
}

- (IBAction)showAllSteps:(id)sender
{
    self.stepCountLabel.text = @"Doing math...";

    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];

    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0];

    __weak typeof(self) weakSelf = self;
    [self.stepCounter queryStepCountStartingFrom:today to:[NSDate date] toQueue:[NSOperationQueue mainQueue] withHandler:^(NSInteger numberOfSteps, NSError *error) {
        weakSelf.stepCountLabel.text = [NSString stringWithFormat:@"%ld steps", (long)numberOfSteps];
    }];
}

@end
