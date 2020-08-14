//
//  APIManager.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "APIManager.h"
#import "LocationManager.h"
#import "User.h"

@interface APIManager()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSString *apiKey;

@end

@implementation APIManager

- (id)init {
    self = [super init];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    self.apiKey = [APIManager getAPIKey:@"DiscountAPIKey"];

    return self;
}

- (void)fetchDealsWithRadius:(double)radius numberOfDeals:(int)number completion:(void(^)(NSArray<Deal *> *deals, NSError *error))completion {
    
    // get location coordinate and user preferences for request
    CLLocationCoordinate2D locationCoordinate = [LocationManager sharedLocationManager].currentLocationCoordinate;
    
    User *user = [User currentUser];
    NSString *preferences = [user.preferenceSlugs componentsJoinedByString:@","];
    
    // put together URL
    NSString *const baseURL = @"https://api.discountapi.com/v2/deals?api_key=%@&location=%f,%f&radius=%f&category_slugs=%@&per_page=%d";
    
    NSString *urlString = [NSString stringWithFormat:baseURL, self.apiKey, locationCoordinate.latitude, locationCoordinate.longitude, radius, preferences, number];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // send request to API
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        }
        else {
            // create array of deals from response
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray<NSDictionary *> *dictionaries = dataDictionary[@"deals"];
            NSArray<Deal *> *deals = [Deal dealsWithDictionaries:dictionaries];
            
            completion(deals, nil);
        }
    }];
    [task resume];
}

- (void)fetchNearbyDeal:(void (^)(Deal *deal, UIBackgroundFetchResult result))completionHandler {
    
    [self fetchDealsWithRadius:0.2 numberOfDeals:1 completion:^(NSArray<Deal *> *deals, NSError *error) {
        if (error != nil) {
            completionHandler(nil, UIBackgroundFetchResultFailed);
        } else {
            if (deals.count != 0) {
                Deal *deal = deals.firstObject;
                completionHandler(deal, UIBackgroundFetchResultNewData);
            } else {
                completionHandler(nil, UIBackgroundFetchResultNoData);
            }
        }
    }];
}

- (void)fetchCategories:(void(^)(NSArray<Category *> *categories, NSError *error))completion {
    
    // put together URL
    NSString *const baseURL = @"https://api.discountapi.com/v2/categories?api_key=";
    NSString *urlString = [baseURL stringByAppendingString:self.apiKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // send request to API
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        }
        else {
            // create array of categories from response
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray<NSDictionary *> *dictionaries = dataDictionary[@"categories"];
            NSArray<Category *> *categories = [Category categoriesWithDictionaries:dictionaries];
            
            completion(categories, nil);
        }
    }];
    [task resume];
}

+ (NSString *)getAPIKey:(NSString *)key {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                    @"APIKeys" ofType:@"plist"];
    NSDictionary *plist = [[NSDictionary alloc] initWithContentsOfFile:path];
    return [plist valueForKey:key];
}

@end
