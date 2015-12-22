//
//  QXGoodsDetailViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TemplateType) {
    TemplateType_Display=0,//default
    TemplateType_Add=1,
};

@class QXGoodsModel;
typedef void(^SaveGoodsBlock)(QXGoodsModel *goodsModel);
@interface QXGoodsDetailViewController : UITableViewController
@property (copy, nonatomic) SaveGoodsBlock saveGoodsBlock;
@property (assign, nonatomic) TemplateType templateType;
- (instancetype)initWithGid:(NSString*)gid;
@end
