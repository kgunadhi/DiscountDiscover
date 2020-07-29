//
//  ProfileViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/16/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "ProfileViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "User.h"
@import Parse;

@interface ProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet PFImageView *profileView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *preferencesLabel;
@property (nonatomic, strong) User *user;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.user = [User currentUser];
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:self.user.username];
    self.emailLabel.text = self.user.email;
    self.preferencesLabel.text = [self.user.preferences componentsJoinedByString:@"\n"];
    
    if (self.user.profileImage) {
        self.profileView.file = self.user.profileImage;
        [self.profileView loadInBackground];
    }
    self.profileView.layer.cornerRadius = self.profileView.frame.size.width / 2;
    self.profileView.clipsToBounds = YES;
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    UIImage *resizedImage = [self resizeImage:editedImage withSize: CGSizeMake(500, 500)];

    self.profileView.image = resizedImage;
    self.user.profileImage = [ProfileViewController getPFFileFromImage:resizedImage];
    [self.user saveInBackground];
    
    // dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:size];
    UIImage *resizedImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull context) {
        [image drawInRect:(CGRect) {.origin = CGPointZero, .size = size}];
    }];
    
    return resizedImage;
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


- (IBAction)logoutUser:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {}];
}

@end
