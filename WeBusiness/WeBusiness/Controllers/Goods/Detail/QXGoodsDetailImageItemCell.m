//
//  QXGoodsDetailImageItemCell.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/23.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsDetailImageItemCell.h"

@interface QXGoodsDetailImageItemCell ()
@end

@implementation QXGoodsDetailImageItemCell


- (void)onLongPress:(UILongPressGestureRecognizer*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(longPressCallBack:)])
    {
        [self.delegate longPressCallBack:self];
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        
        UILongPressGestureRecognizer *longPrees = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
        [self addGestureRecognizer:longPrees];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width);
    self.imageView.bounds = self.bounds;
}

@end
