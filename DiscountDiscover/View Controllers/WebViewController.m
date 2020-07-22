//
//  WebViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/21/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "WebViewController.h"
#import "WebKit/WebKit.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [self.webView loadRequest:request];
}

@end
