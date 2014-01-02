//
//  RBNMotionActivityTableViewController.m
//  CoMotion
//
//  Created by Justin Driscoll on 1/2/14.
//  Copyright (c) 2014 Retrobit, LLC. All rights reserved.
//

#import "RBNMotionActivityTableViewController.h"

@interface RBNMotionActivityTableViewController ()
@property (nonatomic, strong) CMMotionActivityManager *activityManager;

@property (nonatomic, weak) IBOutlet UILabel *timestampLabel;
@property (nonatomic, weak) IBOutlet UILabel *confidenceLabel;
@property (nonatomic, weak) IBOutlet UILabel *isStationaryLabel;
@property (nonatomic, weak) IBOutlet UILabel *isWalkingLabel;
@property (nonatomic, weak) IBOutlet UILabel *isRunningLabel;
@property (nonatomic, weak) IBOutlet UILabel *isAutomotiveLabel;
@property (nonatomic, weak) IBOutlet UILabel *isUnknownLabel;
@end

@implementation RBNMotionActivityTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.userInteractionEnabled = NO;
        self.tableView.bounces = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    BOOL activityInfoAvailable = [CMMotionActivityManager isActivityAvailable];
    if (activityInfoAvailable) {
        if (!self.activityManager) {
            self.activityManager = [[CMMotionActivityManager alloc] init];
        }

        [self.activityManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue]
                                              withHandler:^(CMMotionActivity *activity) {
                                                  self.timestampLabel.text = [NSString stringWithFormat:@"%@", activity.startDate];
                                                  self.confidenceLabel.text = [@(activity.confidence) stringValue];
                                                  self.isStationaryLabel.text = [@(activity.stationary) stringValue];
                                                  self.isWalkingLabel.text = [@(activity.walking) stringValue];
                                                  self.isRunningLabel.text = [@(activity.running) stringValue];
                                                  self.isAutomotiveLabel.text = [@(activity.automotive) stringValue];
                                                  self.isUnknownLabel.text = [@(activity.unknown) stringValue];
                                              }];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    if (self.activityManager) {
        [self.activityManager stopActivityUpdates];
    }
}

@end
