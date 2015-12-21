//
//  QXGoodsMainViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsMainViewController.h"

@interface QXGoodsMainViewController ()

@end

@implementation QXGoodsMainViewController

- (void)loadUI
{
    self.title = @"商品";
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
}



@end
