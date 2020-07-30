//
//  SignUpViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/23/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "SignUpViewController.h"
#import "User.h"
#import "LoginViewController.h"
#import "UIViewController+Error.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signupButton.layer.cornerRadius = 7;
    self.signupButton.clipsToBounds = YES;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)registerUser:(id)sender {
    // initialize a user object
    User *newUser = [User user];
    
    // set user properties
    newUser.email = self.emailField.text;
    newUser.name = self.nameField.text;
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    if ([self emptyField]) {
        [self showErrorAlert:@"Invalid Entry" message:@"Please complete all fields."];
    } else {
        // call sign up function on the user
        __weak typeof(self) weakSelf = self;
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error != nil) {
                    [weakSelf showErrorAlert:@"Sign Up Error" message:error.localizedDescription];
                } else {
                    [weakSelf performSegueWithIdentifier:@"signupSegue" sender:nil];
                }
            });
        }];
    }
}

- (BOOL)emptyField {
    if (self.emailField.text.length == 0
        || self.nameField.text.length == 0
        || self.usernameField.text.length == 0
        || self.passwordField.text.length == 0) {
        return YES;
    }
    return NO;
}



@end
