//
//  DealMarker.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deal.h"
#import <GoogleMaps/GoogleMaps.h>

NS_ASSUME_NONNULL_BEGIN

@interface DealMarker : NSObject

@property (nonatomic, strong) Deal *deal;
@property (nonatomic, strong) GMSMarker *marker;

+ (NSArray<DealMarker *> *)markersWithDeals:(NSArray<Deal *> *)deals map:(GMSMapView *)map;

@end

NS_ASSUME_NONNULL_END
