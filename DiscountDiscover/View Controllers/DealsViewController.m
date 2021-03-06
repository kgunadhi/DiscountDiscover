//
//  DealsViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DealsViewController.h"
#import "DealCell.h"
#import "APIManager.h"
#import "DetailsViewController.h"
#import "ActionSheetPicker.h"
#import "LocationManager.h"
#import "MapViewController.h"
#import "UIViewController+Error.h"
#import <UserNotifications/UserNotifications.h>

@interface DealsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITabBarControllerDelegate, UNUserNotificationCenterDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<Deal *> *deals;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIButton *distanceButton;
@property (nonatomic) double radius;
@property (nonatomic) int selectedIndex;

@end

@implementation DealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.tabBarController.delegate = self;
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    // distance filter
    self.distanceButton.layer.cornerRadius = 15;
    self.radius = 5;
    self.selectedIndex = 3;
    
    [self fetchDeals];
    
    // add refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchDeals) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
}

- (void)viewDidLayoutSubviews {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    const int sectionInsets = 20;
    const int dealsPerLine = 2;
    
    const CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing - sectionInsets) / dealsPerLine;
    const CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)fetchDeals {
    APIManager *manager = [[APIManager alloc] init];
    __weak typeof(self) weakSelf = self;
    [manager fetchDealsWithRadius:self.radius numberOfDeals:20 completion:^(NSArray<Deal *> *deals, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (error != nil) {
                [strongSelf showNetworkErrorAlertWithCompletion:^(UIAlertAction * _Nonnull action) {
                    [strongSelf fetchDeals];
                }];
            }
            else {
                strongSelf.deals = deals;
                [strongSelf.collectionView reloadData];
            }
            [strongSelf.refreshControl endRefreshing];
        }
    }];
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController.restorationIdentifier isEqual: @"MapNavigationController"]) {
        UINavigationController *nc = (UINavigationController *)viewController;
        MapViewController *vc = (MapViewController *)nc.viewControllers.firstObject;
        vc.deals = self.deals;
    }
    return YES;
}

- (IBAction)filterDistance:(id)sender {
    NSArray<NSNumber *> *const distances = @[@(0.5), @(1), @(2), @(5), @(10), @(20)];

    __weak typeof(self) weakSelf = self;
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.radius = [selectedValue doubleValue];
            strongSelf.selectedIndex = selectedIndex;
            [strongSelf fetchDeals];
        }
    };
    ActionStringCancelBlock cancel = nil;
    
    [ActionSheetStringPicker showPickerWithTitle:@"Distance (mi)" rows:distances initialSelection:self.selectedIndex doneBlock:done cancelBlock:cancel origin:sender];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DealCell" forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.deals.count;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    NSData *dealData = response.notification.request.content.userInfo[@"Deal"];
    Deal *deal = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray: @[Deal.class, NSURL.class]] fromData:dealData error:nil];

    if (deal != nil) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailsViewController *detailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
        detailsViewController.deal = deal;
        [self.navigationController pushViewController:detailsViewController animated:YES];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Details view segue
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Deal *deal = self.deals[indexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.deal = deal;
}

@end
