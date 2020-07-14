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
