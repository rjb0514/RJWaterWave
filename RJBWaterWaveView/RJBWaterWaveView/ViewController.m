//
//  ViewController.m
//  RJBWaterWaveView
//
//  Created by ru on 2018/6/4.
//  Copyright © 2018年 ru. All rights reserved.
//

#import "ViewController.h"
#import "RJBWaterView.h"

@interface ViewController ()

@property (nonatomic, strong) RJBWaterView         *waterView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.waterView = [[RJBWaterView alloc] initWithFrame:CGRectMake(100, 100, 300, 200)];
    [self.view addSubview:self.waterView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
