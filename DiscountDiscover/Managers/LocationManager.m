//
//  LocationManager.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/29/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

- (id)init {
    self = [super init];

    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startMonitoringSignificantLocationChanges];

    return self;
}

+ (LocationManager *)sharedLocationManager {
    static LocationManager *sharedLocationManager;
    if (!sharedLocationManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedLocationManager = [[LocationManager alloc] init];
        });
    }

    return sharedLocationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    self.currentLocation = [locations lastObject];
    self.currentLocationCoordinate = self.currentLocation.coordinate;
}

@end
