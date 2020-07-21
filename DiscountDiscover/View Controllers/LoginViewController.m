//
//  LoginViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/16/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.layer.cornerRadius = 7;
    self.loginButton.clipsToBounds = YES;
    self.signupButton.layer.cornerRadius = 7;
    self.signupButton.clipsToBounds = YES;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)registerUser:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    if ([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]) {
        [self showErrorAlert:@"Invalid Entry" message:@"Username or password field is empty."];
    } else {
        // call sign up function on the user
        __weak LoginViewController *weakSelf = self;
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            LoginViewController *strongSelf = weakSelf;
            if (error != nil) {
                [strongSelf showErrorAlert:@"Sign Up Error" message:error.localizedDescription];
            } else {
                [strongSelf performSegueWithIdentifier:@"loginSegue" sender:nil];
            }
        }];
    }
}

- (IBAction)loginUser:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    __weak LoginViewController *weakSelf = self;
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        LoginViewController *strongSelf = weakSelf;
        if (error != nil) {
            [strongSelf showErrorAlert:@"Login Error" message:error.localizedDescription];
        } else {
            [strongSelf performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
