//
//  PreferencesViewController.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PreferencesViewControllerDelegate

- (void)didEditPreferences;

@end

@interface PreferencesViewController : UIViewController

@property (nonatomic, weak) id<PreferencesViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
