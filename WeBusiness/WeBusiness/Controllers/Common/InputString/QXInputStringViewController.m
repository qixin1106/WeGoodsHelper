//
//  QXInputStringViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/21.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXInputStringViewController.h"

@interface QXInputStringViewController ()
@property (strong, nonatomic) UITextView *textView;
@end

@implementation QXInputStringViewController


- (void)onDoneClick:(UIBarButtonItem*)sender
{
    if (self.editDoneBlock)
    {
        self.editDoneBlock(self.textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadUI
{
    self.title = @"编辑";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(onDoneClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.font = [UIFont systemFontOfSize:17];
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    self.textView.text = self.placeHolder;
    self.textView.keyboardType = self.keyboardType;
    [self.view addSubview:self.textView];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:0]];
    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
}

@end
