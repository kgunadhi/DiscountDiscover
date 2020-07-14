//
//  Deal.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Deal : NSObject

@property (nonatomic, strong) NSString *name;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)dealsWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
