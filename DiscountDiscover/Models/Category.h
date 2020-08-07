//
//  Category.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Category : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *slug;

+ (NSArray<Category *> *)categoriesWithDictionaries:(NSArray<NSDictionary *> *)dictionaries;

@end

NS_ASSUME_NONNULL_END
