//
//  ViewController.m
//  Clocc
//
//  Created by Jese on 26.12.2019.
//  Copyright © 2019 jpitkanen18. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (nonatomic, assign) id<CLLocationManagerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestWhenInUseAuthorization];
    _locationManager.delegate = self.delegate;
    [self.locationManager startUpdatingLocation];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    NSLog(@"%@", self.locationManager.location);
    [_cityLabel setHidden:true];
    [self seconds];
    [self time];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(seconds) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [self locations];
}

- (void) seconds{
    NSDate * now = [NSDate date];
    NSDateFormatter * outputSec = [[NSDateFormatter alloc] init];
    [outputSec setDateFormat:@":ss"];
    NSString *secondsString = [outputSec stringFromDate:now];
    if ([secondsString  isEqual: @":00"]){
        [self time];
    }
    [_secondLabel setText:secondsString];
}
- (void) time{
    NSDate * now = [NSDate date];
    NSDateFormatter * output = [[NSDateFormatter alloc] init];
    [output setDateFormat:@"HH:mm"];
    NSString *timeString = [output stringFromDate:now];
    [_timeLabel setText:timeString];
}

- (void)locations{
    if(self.locationManager.location == NULL){
        [self locations];
    }
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self.locationManager.location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       NSLog(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");

                       if (error){
                           NSLog(@"Geocode failed with error: %@", error);
                           [self->_cityLabel setText:@"error :D"];
                           return;

                       }


                       CLPlacemark *placemark = [placemarks objectAtIndex:0];
                       [self->_cityLabel setHidden:false];
                       [self->_cityLabel setText:placemark.locality];

                   }];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self locations];
}
@end
