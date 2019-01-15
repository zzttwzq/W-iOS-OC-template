//
//  ViewController.m
//  template
//
//  Created by 吴志强 on 2019/1/14.
//  Copyright © 2019 吴志强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[UIViewController new]] animated:YES completion:nil];
}

@end
