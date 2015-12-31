//
//  QXOrderDetailMoreView.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/29.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXOrderDetailMoreView.h"
#import "QXOrderGoodsModel.h"
@interface QXOrderDetailMoreView ()
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *costTf;
@property (weak, nonatomic) IBOutlet UITextField *priceTf;
@property (weak, nonatomic) IBOutlet UITextField *countTf;
@end

@implementation QXOrderDetailMoreView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.costTf.delegate = self;
    self.priceTf.delegate = self;
    self.countTf.delegate = self;
}


- (void)setModel:(QXOrderGoodsModel *)model
{
    if (_model!=model)
    {
        _model=model;
    }
    self.costTf.text = STR_FORMAT(@"%.2f",_model.adjustCost);
    self.priceTf.text = STR_FORMAT(@"%.2f",_model.adjustPrice);
    self.countTf.text = STR_FORMAT(@"%ld",_model.buyCount);
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 0://进价
        {
            self.model.adjustCost = [textField.text floatValue];
            break;
        }
        case 1://售价
        {
            self.model.adjustPrice = [textField.text floatValue];
            break;
        }
        case 2://数量
        {
            self.model.buyCount = [textField.text integerValue];
            break;
        }
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeValueCallback:)])
    {
        [self.delegate changeValueCallback:self];
    }
    return YES;
}
@end
