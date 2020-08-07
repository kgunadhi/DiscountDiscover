//
//  UIViewController+Error.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/29/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "UIViewController+Error.h"

@implementation UIViewController (Error)

- (void)showErrorAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:title
                                                                        message:message
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
      style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * _Nonnull action) {}];
    [errorAlert addAction:okAction];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)showNetworkErrorAlertWithCompletion:(void (^)(UIAlertAction * _Nonnull action))completion {
    UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"Cannot Get Deals" message:@"The Internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *reloadAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:completion];
    [networkAlert addAction:reloadAction];
    
    [self presentViewController:networkAlert animated:YES completion:^{}];
}

@end
