//
//  QXOrderMainViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderMainViewController.h"

@interface QXOrderMainViewController ()

@end

@implementation QXOrderMainViewController


- (void)loadUI
{
    self.title = @"订单";
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
}


@end
