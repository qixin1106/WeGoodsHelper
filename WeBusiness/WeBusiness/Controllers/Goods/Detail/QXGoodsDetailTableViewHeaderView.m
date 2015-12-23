//
//  QXGoodsDetailTableViewHeaderView.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsDetailTableViewHeaderView.h"
#import "QXGoodsDetailImageItemCell.h"
#import "UIImage+Utils.h"

static NSString *itemID = @"QXGoodsDetailImageItemCell";

@interface QXGoodsDetailTableViewHeaderView ()
<UICollectionViewDataSource,UICollectionViewDelegate,QXGoodsDetailImageItemCellDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *imgs;
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation QXGoodsDetailTableViewHeaderView


- (void)setPicID:(NSString *)picID
{
    if (_picID!=picID)
    {
        _picID=picID;
        _imgs = [NSMutableArray arrayWithArray:[_picID componentsSeparatedByString:@";"]];
        self.pageControl.numberOfPages = _imgs.count+1;
        [self.collectionView reloadData];
    }
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width);
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = self.bounds.size;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[QXGoodsDetailImageItemCell class] forCellWithReuseIdentifier:itemID];
        
        
        
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.userInteractionEnabled = NO;
        self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        self.pageControl.hidesForSinglePage = YES;
        self.pageControl.pageIndicatorTintColor = RGBA(235, 235, 235, 1);
        self.pageControl.currentPageIndicatorTintColor = RGBA(255, 128, 0, 1);
        self.pageControl.currentPage = 0;
        [self addSubview:self.pageControl];
        
        
        
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                          constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1
                                                          constant:0]];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                          constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1
                                                          constant:0]];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width);
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgs.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QXGoodsDetailImageItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    if (indexPath.row==self.imgs.count)
    {
        cell.imageView.image = [UIImage imageNamed:@"add"];
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                UIImage *image = [UIImage imageWithPicID:self.imgs[indexPath.row]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = (image)?image:[UIImage imageNamed:@"mb"];
                });
            }
        });
    }
    return cell;
}




#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==self.imgs.count)
    {
        QXLog(@"增加图片!");
        if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:isAddImage:picID:)])
        {
            [self.delegate headerView:self isAddImage:YES picID:nil];
        }
    }
    else
    {
        QXLog(@"点图片查看大图");
        if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:isAddImage:picID:)])
        {
            [self.delegate headerView:self isAddImage:NO picID:self.imgs[indexPath.row]];
        }
    }
    
}








#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (scrollView.contentOffset.x+scrollView.bounds.size.width*0.5)/scrollView.bounds.size.width;
}













#pragma mark - QXGoodsDetailImageItemCellDelegate
- (void)longPressCallBack:(QXGoodsDetailImageItemCell*)cell
{
    if (cell.indexPath.row==self.imgs.count)//最后一张是+
    {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:longPressPicID:longPressCell:)])
    {
        [self.delegate headerView:self longPressPicID:self.imgs[cell.indexPath.row] longPressCell:cell];
    }
}




@end
