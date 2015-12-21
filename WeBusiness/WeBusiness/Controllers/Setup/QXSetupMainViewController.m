//
//  QXSetupMainViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXSetupMainViewController.h"

@interface QXSetupMainViewController ()

@end

@implementation QXSetupMainViewController

- (void)loadUI
{
    self.title = @"设置";
    self.tableView.tableFooterView = [UIView new];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
}


@end
