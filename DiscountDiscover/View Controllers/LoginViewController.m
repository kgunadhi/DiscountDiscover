//
//  LoginViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/16/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "UIViewController+Error.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.layer.cornerRadius = 7;
    self.loginButton.clipsToBounds = YES;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)loginUser:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
            if (error != nil) {
                [weakSelf showErrorAlert:@"Login Error" message:error.localizedDescription];
            } else {
                [weakSelf performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
    });
}

@end
