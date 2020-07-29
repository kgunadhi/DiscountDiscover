//
//  LocationManager.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/29/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic) CLLocationCoordinate2D currentLocationCoordinate;

+ (LocationManager *)sharedLocationManager;

@end

NS_ASSUME_NONNULL_END
