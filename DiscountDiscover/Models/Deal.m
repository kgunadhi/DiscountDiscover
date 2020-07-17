//
//  Deal.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "Deal.h"

@implementation Deal

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    NSDictionary *deal = dictionary[@"deal"];
    self.name = deal[@"title"];
//    self.description = deal[@"description"];
    self.finePrint = deal[@"fine_print"];
    self.url = [NSURL URLWithString:deal[@"url"]];
    self.category = deal[@"category_name"];
    self.imageUrl = [NSURL URLWithString:deal[@"image_url"]];
    self.expiresAt = deal[@"expiresAt"];
    
    NSDictionary *store = deal[@"merchant"];
    self.storeName = store[@"name"];
    self.storeAddress = store[@"address"];
    double latitude = [store[@"latitude"] doubleValue];
    double longitude = [store[@"longitude"] doubleValue];
    self.storeCoordinate = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude].coordinate;

    return self;
}

+ (NSArray *)dealsWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *deals = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Deal *deal = [[Deal alloc] initWithDictionary:dictionary];
        [deals addObject:deal];
    }
    return deals;
}

@end
