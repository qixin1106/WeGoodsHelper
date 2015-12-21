//
//  RootViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXRootViewController.h"

#import "QXOrderMainViewController.h"
#import "QXGoodsMainViewController.h"
#import "QXCustomerMainViewController.h"
#import "QXSetupMainViewController.h"


@interface QXRootViewController ()

@end

@implementation QXRootViewController




- (void)loadUI
{
    NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:4];
    {
        QXOrderMainViewController *vc = [[QXOrderMainViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:nav];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"订单" image:[UIImage imageNamed:@"TestTabbarIcon"] tag:0];
        vc.tabBarItem = tabBarItem;
    }
    {
        QXGoodsMainViewController *vc = [[QXGoodsMainViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:nav];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商品" image:[UIImage imageNamed:@"TestTabbarIcon"] tag:1];
        vc.tabBarItem = tabBarItem;
    }
    {
        QXCustomerMainViewController *vc = [[QXCustomerMainViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:nav];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"客户" image:[UIImage imageNamed:@"TestTabbarIcon"] tag:2];
        vc.tabBarItem = tabBarItem;
    }
    {
        QXSetupMainViewController *vc = [[QXSetupMainViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [controllers addObject:nav];
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"TestTabbarIcon"] tag:3];
        vc.tabBarItem = tabBarItem;
    }
    self.viewControllers = controllers;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
}


@end
