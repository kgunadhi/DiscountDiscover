//
//  UIViewController+Error.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/29/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Error)

- (void)showErrorAlert:(NSString *)title message:(NSString *)message;
- (void)showNetworkErrorAlertWithCompletion:(void (^)(UIAlertAction * _Nonnull action))completion;

@end

NS_ASSUME_NONNULL_END
