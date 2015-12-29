//
//  QXCustomerModel+TypeTranslation.h
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/21.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXCustomerModel.h"

@interface QXCustomerModel (TypeTranslation)
- (NSString*)typeToString;
//汉字转拼音
- (NSString*)nameToPinyin;
//拼音首字母,排序用
- (NSString*)nameToPinyinFirstChar;
@end
