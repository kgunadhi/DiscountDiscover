//
//  Category.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "Category.h"

@implementation Category

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    NSDictionary *category = dictionary[@"category"];
    self.name = category[@"name"];
    self.slug = category[@"slug"];
    
    return self;
}

+ (NSArray<Category *> *)categoriesWithDictionaries:(NSArray<NSDictionary *> *)dictionaries {
    
    NSMutableArray<Category *> *categories = [NSMutableArray<Category *> array];
    for (NSDictionary *dictionary in dictionaries) {
        Category *category = [[Category alloc] initWithDictionary:dictionary];
        [categories addObject:category];
    }
    return categories;
}

@end
