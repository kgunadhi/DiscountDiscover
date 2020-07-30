//
//  MapViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/15/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "MapViewController.h"
#import "APIManager.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationManager.h"

@interface MapViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) GMSMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationCoordinate2D locationCoordinate = [LocationManager sharedLocationManager].currentLocationCoordinate;

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationCoordinate.latitude longitude:locationCoordinate.longitude zoom:17];
    self.mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    self.mapView.settings.myLocationButton = YES;
    self.mapView.myLocationEnabled = YES;
    [self.view addSubview:self.mapView];
    
    [self addDealMarkers];
}

- (void)addDealMarkers {
    for (Deal *deal in self.deals) {
        deal.marker.map = self.mapView;
    }
}

@end
