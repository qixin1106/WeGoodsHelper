//
//  QXGoodsMainViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/18.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsMainViewController.h"

#import "QXGoodsModel.h"
#import "QXGoodsMainCell.h"

static NSString *identifier = @"QXGoodsMainCell";

@interface QXGoodsMainViewController () <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic, nonnull) NSMutableArray *dataArray;
@end

@implementation QXGoodsMainViewController






- (void)onAddClick:(UIBarButtonItem*)sender
{
    QXGoodsModel *goodsModel = [[QXGoodsModel alloc] init];
    goodsModel.name = @"笨笨熊蚕丝儿童爬行护膝 宝宝圣诞礼物 宝宝防摔 夏季透气";
    goodsModel.costPrice = 100.00;
    goodsModel.delegatePrice = 140.00;
    goodsModel.friendPrice = 130.00;
    goodsModel.retailPrice = 150.00;
    goodsModel.count = 50;
    goodsModel.descs = @"尺码仅供参考，误差在1-2公分以内为正常现象，特别是针织弹力面料。请根据自己穿衣习惯选择.,内胆类型: 棉内胆品牌: other/其他安全等级: A类材质成分: 棉96% 其他4%货号: CBA-5适用性别: 中性里料材质成分: 棉96% 其他4%颜色分类: 军绿色 红色 黑色参考身高: 吊牌5码 吊牌7码 吊牌9码 吊牌11码 吊牌13码模特实拍: 实拍有模特是否带帽子: 有帽可拆厚薄: 加厚衣门襟: 拉链衫领型: 圆领风格: 韩版面料: 纯棉(95%及以上)图案: 卡通动漫填充物: 棉96%及以上";
    goodsModel.picID = nil;
    goodsModel.remark = @"XXX进货";
    [goodsModel store];
    [self loadData];
    [self.tableView reloadData];
}

- (void)loadData
{
    QXGoodsModel *goodsModel = [[QXGoodsModel alloc] init];
    self.dataArray = [NSMutableArray arrayWithArray:[goodsModel fetchAll]];
}

- (void)loadUI
{
    self.title = @"商品";
    self.tableView.tableFooterView = [UIView new];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddClick:)];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QXGoodsMainCell class] forCellReuseIdentifier:identifier];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}








#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXGoodsMainCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.goodsModel = self.dataArray[indexPath.row];
    return cell;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
