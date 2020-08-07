//
//  PreferencesViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "PreferencesViewController.h"
#import "APIManager.h"
#import "UIViewController+Error.h"
#import "CategoryCell.h"
#import "User.h"

@interface PreferencesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) NSArray<Category *> *categories;
@property (nonatomic, strong) User *user;

@end

@implementation PreferencesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.doneButton.layer.cornerRadius = 7;
    self.doneButton.clipsToBounds = YES;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.user = [User currentUser];
    
    [self fetchCategories];
}

- (void)fetchCategories {
    APIManager *manager = [[APIManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [manager fetchCategories:^(NSArray<Category *> *categories, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (error != nil) {
                [strongSelf showNetworkErrorAlertWithCompletion:^(UIAlertAction * _Nonnull action) {
                    [strongSelf fetchCategories];
                }];
            }
            else {
                strongSelf.categories = categories;
                [strongSelf.tableView reloadData];
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
}

- (IBAction)finishPreferences:(id)sender {
    NSArray<NSIndexPath *> *selectedPaths = [self.tableView indexPathsForSelectedRows];
    if (selectedPaths == nil) {
        [self showErrorAlert:@"Invalid Selection" message:@"Please select at least one category."];
    } else {
        // get category names and slugs of all selected categories
        NSMutableArray<NSString *> *categoryNames = [NSMutableArray<NSString *> array];
        NSMutableArray<NSString *> *categorySlugs = [NSMutableArray<NSString *> array];
        for (NSIndexPath *indexPath in selectedPaths) {
            Category *category = self.categories[indexPath.row];
            [categoryNames addObject:category.name];
            [categorySlugs addObject:category.slug];
        }
        
        // save user preferences
        self.user.preferenceNames = categoryNames;
        self.user.preferenceSlugs = categorySlugs;
        [self.user saveInBackground];
        
        if (self.delegate) {
            [self.delegate didEditPreferences];
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            [self performSegueWithIdentifier:@"dealsSegue" sender:nil];
        }
    }
}

@end
