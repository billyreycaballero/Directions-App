//
//  ViewController.m
//  Directions
//
//  Created by Billy Rey Caballero on 16/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation *marinaAnno;
@property (strong, nonatomic) MKPointAnnotation *changiAnno;
@property (strong, nonatomic) MKPointAnnotation *jurongAnno;
@property (strong, nonatomic) MKPointAnnotation *currentAnno;
@property (weak, nonatomic) IBOutlet UISwitch *switchShow;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL mapIsMoving;

@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.mapIsMoving = NO;
    [self AddAnnotations];
}

- (IBAction)switchToLoc:(id)sender {
    if(self.switchShow.isOn){
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    } else {
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    self.currentAnno.coordinate = locations.lastObject.coordinate;
    if(self.mapIsMoving == NO) {
        [self centerMap:self.currentAnno];
    }
    [self centerMap:self.currentAnno];
}

- (IBAction)marinaButton:(id)sender {
    [self centerMap:self.marinaAnno];
}

- (IBAction)changiButton:(id)sender {
    [self centerMap:self.changiAnno];
}

- (IBAction)jurongButton:(id)sender {
    [self centerMap:self.jurongAnno];
}

- (void) centerMap:(MKPointAnnotation *) centerPoint {
    [self.mapView setCenterCoordinate:centerPoint.coordinate];
}

- (void) AddAnnotations{
    self.marinaAnno = [[MKPointAnnotation alloc] init];
    self.marinaAnno.coordinate = CLLocationCoordinate2DMake(1.2836, 103.8607);
    self.marinaAnno.title = @"Marina Bay Sand";
    
    self.changiAnno = [[MKPointAnnotation alloc] init];
    self.changiAnno.coordinate = CLLocationCoordinate2DMake(1.3644, 103.9915);
    self.changiAnno.title = @"Changi Airport";
    
    self.jurongAnno = [[MKPointAnnotation alloc] init];
    self.jurongAnno.coordinate = CLLocationCoordinate2DMake(1.3395, 103.7066);
    self.jurongAnno.title = @"Jurong Point Mall";
    
    self.currentAnno = [[MKPointAnnotation alloc] init];
    self.currentAnno.coordinate = CLLocationCoordinate2DMake(0.0, 0.0);
    self.currentAnno.title = @"My Location";
    
    [self.mapView addAnnotations: @[self.marinaAnno, self.changiAnno, self.jurongAnno]];
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    self.mapIsMoving = YES;
}


- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    self.mapIsMoving = NO;
}


@end
