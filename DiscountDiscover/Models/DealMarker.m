//
//  DealMarker.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DealMarker.h"

@implementation DealMarker

- (id)initWithDeal:(Deal *)deal map:(GMSMapView *)map {
    self = [super init];

    self.deal = deal;
    
    self.marker = [GMSMarker markerWithPosition:self.deal.storeCoordinate];
    self.marker.title = deal.storeName;
    self.marker.snippet = deal.name;
    self.marker.map = map;
    self.marker.userData = deal;
    
    return self;
}

+ (NSArray<DealMarker *> *)markersWithDeals:(NSArray<Deal *> *)deals map:(GMSMapView *)map {
    
    NSMutableArray<DealMarker *> *markers = [NSMutableArray<DealMarker *> array];
    for (Deal *deal in deals) {
        DealMarker *marker = [[DealMarker alloc] initWithDeal:deal map:map];
        [markers addObject:marker];
    }
    return markers;
}

@end
