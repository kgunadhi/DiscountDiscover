//
//  User.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/29/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFUser<PFSubclassing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<NSString *> *preferences;
@property (nonatomic, strong) PFFileObject *profileImage;

@end

NS_ASSUME_NONNULL_END
