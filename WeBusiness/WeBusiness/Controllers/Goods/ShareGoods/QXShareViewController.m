//
//  QXShareViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXShareViewController.h"
#import "QXGoodsModel.h"
#import "QXGoodsModel+Utils.h"
#import "UIImage+Utils.h"

@interface QXShareViewController ()
@property (strong, nonatomic) QXGoodsModel *goodsModel;
@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation QXShareViewController


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error)
    {
        ALERT(@"保存成功", nil);
    }
    else
    {
        ALERT(@"保存失败", nil);
    }
}

- (void)onShareClick:(UIBarButtonItem*)sender
{
    /*
    self.scrollView.bounds = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    UIImage *image = [UIImage screenShotWithView:self.scrollView];
    self.scrollView.bounds = self.view.bounds;
    NSArray *postItems = @[image];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
    [controller setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        
    }];
     */
    
    NSString *sharedText = STR_FORMAT(@"%@\n\n%@",self.goodsModel.name,self.goodsModel.descs);
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:sharedText];


    NSArray *picIDArray = [self.goodsModel.picID componentsSeparatedByString:@";"];
    NSMutableArray *images = [NSMutableArray array];
    [picIDArray enumerateObjectsUsingBlock:^(NSString * _Nonnull picID, NSUInteger idx, BOOL * _Nonnull stop) {
        [images addObject:[UIImage imageWithPicID:picID]];
        if (idx>=8)
        {
            *stop = YES;
        }
    }];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:images applicationActivities:nil];
    [self presentViewController:controller animated:YES completion:nil];
    [controller setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        
    }];

}



- (void)loadUI
{
    self.title = @"预览分享";
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(onShareClick:)];
    self.navigationItem.rightBarButtonItem = shareItem;

    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameLabel.font = [UIFont boldSystemFontOfSize:21];
    nameLabel.numberOfLines = 0;
    nameLabel.lineBreakMode = NSLineBreakByCharWrapping;
    nameLabel.textColor = RGBA(55, 55, 55, 1);
    nameLabel.text = self.goodsModel.name;
    [self.scrollView addSubview:nameLabel];
    ;
    
    
    
    UILabel *descsLabel = [[UILabel alloc] init];
    descsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    descsLabel.font = [UIFont systemFontOfSize:17];
    descsLabel.numberOfLines = 0;
    descsLabel.lineBreakMode = NSLineBreakByCharWrapping;
    descsLabel.textColor = RGBA(128, 128, 128, 1);
    descsLabel.text = self.goodsModel.descs;
    [self.scrollView addSubview:descsLabel];
    
    
    
    

    
    /************************************************************************************/
    
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:10]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1
                                                                 constant:10]];
    [nameLabel addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:self.view.bounds.size.width-20]];
    [nameLabel addConstraint:[NSLayoutConstraint constraintWithItem:nameLabel
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:[nameLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height]];
    
    
    
    /************************************************************************************/
    
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:descsLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nameLabel
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:10]];
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:descsLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.scrollView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1
                                                                 constant:10]];
    [descsLabel addConstraint:[NSLayoutConstraint constraintWithItem:descsLabel
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:nil
                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                          multiplier:1
                                                            constant:self.view.bounds.size.width-20]];
    [descsLabel addConstraint:[NSLayoutConstraint constraintWithItem:descsLabel
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:[descsLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height]];
    
    
    
    
    
    
    
    
    
    [self.view setNeedsDisplay];
    [self.view layoutIfNeeded];
    
    if (VALID_STRING(self.goodsModel.picID))
    {
        NSArray *picIDArray = [self.goodsModel.picID componentsSeparatedByString:@";"];
        __block UIView *lastView = descsLabel;
        [picIDArray enumerateObjectsUsingBlock:^(NSString * _Nonnull picID, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImage *img = [UIImage imageWithPicID:picID];
            CGFloat height = img.size.height * self.view.bounds.size.width / img.size.width;
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
            imageView.frame = CGRectMake(0,
                                         lastView.frame.origin.y+lastView.frame.size.height+10,
                                         self.view.bounds.size.width, height);
            [self.scrollView addSubview:imageView];
            lastView = imageView;
            
            self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, imageView.frame.origin.y+imageView.frame.size.height);
            /************************************************************************************/
        }];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadUI];
}


- (instancetype)initWithGoodsModel:(QXGoodsModel*)goodsModel
{
    self = [super init];
    if (self)
    {
        self.goodsModel = goodsModel;
    }
    return self;
}

@end
