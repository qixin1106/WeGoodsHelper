//
//  QXGoodsDetailViewController.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, TemplateType) {
    TemplateType_Edit=0,//default
    TemplateType_Add=1,
};

@class QXGoodsModel;
typedef void(^SaveGoodsBlock)(QXGoodsModel *goodsModel);
@interface QXGoodsDetailViewController : QXBaseTableViewController
@property (copy, nonatomic) SaveGoodsBlock saveGoodsBlock;
@property (assign, nonatomic) TemplateType templateType;
- (instancetype)initWithGid:(NSString*)gid;
@end
