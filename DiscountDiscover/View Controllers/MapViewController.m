//
//  MapViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/15/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "MapViewController.h"
#import "APIManager.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManager.h"

@interface MapViewController () <CLLocationManagerDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationCoordinate2D locationCoordinate = [LocationManager sharedLocationManager].currentLocationCoordinate;

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationCoordinate.latitude longitude:locationCoordinate.longitude zoom:17];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.settings.myLocationButton = YES;
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];
}

@end
