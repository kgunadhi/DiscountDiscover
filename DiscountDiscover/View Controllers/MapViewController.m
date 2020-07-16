//
//  MapViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/15/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <CLLocationManagerDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    CLLocationCoordinate2D locationCoordinate = locationManager.location.coordinate;
    [locationManager stopUpdatingLocation];

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationCoordinate.latitude longitude:locationCoordinate.longitude zoom:17];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.settings.myLocationButton = YES;
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];
}

@end
