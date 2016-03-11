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

#import "QXGoodsDetailViewController.h"

#import "QXGoodsMainMoreView.h"

#import "QXSearchResultViewController.h"

static NSString *identifier = @"QXGoodsMainCell";

@interface QXGoodsMainViewController ()
<UITableViewDataSource,
UITableViewDelegate,
QXGoodsMainCellDelegate,
UISearchBarDelegate,
UISearchResultsUpdating,
UISearchControllerDelegate,
QXSearchResultViewControllerDelegate>
@property (strong, nonatomic, nonnull) NSMutableArray *dataArray;
@property (strong, nonatomic, nullable) QXGoodsMainMoreView *moreView;
@property (strong, nonatomic, nullable) NSArray *pySortArray;
@property (strong, nonatomic, nonnull) UISearchController *searchController;
@property (strong, nonatomic, nonnull) QXSearchResultViewController *srvc;
@property (assign, nonatomic) NSInteger start;
@property (assign, nonatomic) BOOL isCanLoad;
@end

@implementation QXGoodsMainViewController






- (void)removeMoreView
{
    if (self.moreView)
    {
        [self.moreView removeFromSuperview];
        self.moreView = nil;
    }
}


- (void)onAddClick:(UIBarButtonItem*)sender
{
    QXGoodsDetailViewController *vc = [[QXGoodsDetailViewController alloc] initWithGid:nil];
    vc.templateType = TemplateType_Add;
    [vc setSaveGoodsBlock:^(QXGoodsModel *goodsModel) {
        //保存
        ([goodsModel fetchModel])?[goodsModel refresh]:[goodsModel store];
        [self loadData:NO];
        [self.tableView reloadData];
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:NULL];    
}

- (void)loadData:(BOOL)isAdd
{
    self.isCanLoad = NO;
    QXGoodsModel *goodsModel = [[QXGoodsModel alloc] init];
    if (isAdd)
    {
        NSArray *fetchModels = [goodsModel fetchStart:self.start size:FETCH_SIZE];
        self.isCanLoad = (fetchModels.count<FETCH_SIZE)?NO:YES;
        self.start = (self.isCanLoad)?self.start+1:self.start;
        [self.dataArray addObjectsFromArray:fetchModels];
    }
    else
    {
        self.start = 0;
        NSArray *fetchModels = [goodsModel fetchStart:self.start size:FETCH_SIZE];
        self.isCanLoad = (fetchModels.count<FETCH_SIZE)?NO:YES;
        self.start = (self.isCanLoad)?self.start+1:self.start;
        self.dataArray = [NSMutableArray arrayWithArray:fetchModels];
    }
}

- (void)loadUI
{
    self.title = (self.type==Type_Display)?@"库存":@"选择商品";
    self.tableView.tableFooterView = [UIView new];
    self.hidesBottomBarWhenPushed = NO;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddClick:)];
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QXGoodsMainCell class] forCellReuseIdentifier:identifier];
    
    self.srvc = [[QXSearchResultViewController alloc] initWithStyle:UITableViewStyleGrouped searchType:SearchType_Goods];
    self.srvc.delegate = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.srvc];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"搜索商品名/商品描述/备注";
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData:NO];
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
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.goodsModel = self.dataArray[indexPath.row];
    return cell;
}



#pragma mark - UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeMoreView];
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        QXGoodsModel *model = self.dataArray[indexPath.row];
        [model remove];
        [self.dataArray removeObject:model];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView endUpdates];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==Type_Display)//展示
    {
        QXGoodsModel *model = self.dataArray[indexPath.row];
        QXGoodsDetailViewController *vc = [[QXGoodsDetailViewController alloc] initWithGid:model.ID];
        vc.hidesBottomBarWhenPushed = YES;
        vc.templateType = TemplateType_Edit;
        [vc setSaveGoodsBlock:^(QXGoodsModel *goodsModel) {
            //保存
            ([goodsModel fetchModel])?[goodsModel refresh]:[goodsModel store];
            [self loadData:NO];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
        [self removeMoreView];
    }
    if (self.type==Type_Select)//选择
    {
        QXGoodsModel *model = self.dataArray[indexPath.row];
        //2016-01-16 亓鑫 根据用户需求就算是0商品数量也可添加,暂时不做动态调整库存商品数量功能/////////
        if (YES)//(model.count)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectedGoods:)])
            {
                [self.delegate selectedGoods:model];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            ALERT(@"库存不足", nil);
        }
    }
}






#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self removeMoreView];
    if (scrollView.contentOffset.y+scrollView.frame.size.height>scrollView.contentSize.height && self.isCanLoad)
    {
        [self loadData:YES];
        [self.tableView reloadData];
    }
}






#pragma mark - QXGoodsMainCellDelegate
- (void)onClickMoreCallBack:(QXGoodsMainCell*)cell
{
    CGRect cellFrame = [self.tableView rectForRowAtIndexPath:[self.tableView indexPathForCell:cell]];
    
    [self removeMoreView];
    
    self.moreView = [[QXGoodsMainMoreView alloc] init];
    [self.moreView addTarget:self action:@selector(removeMoreView) forControlEvents:UIControlEventTouchUpInside];
    self.moreView.frame = CGRectMake(self.view.bounds.size.width, cellFrame.origin.y, cell.line.frame.size.width, cellFrame.size.height-1);
    [self.tableView addSubview:self.moreView];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.moreView.frame = FRAME_ORIGINX(self.moreView, cell.line.frame.origin.x);
    }];
}
















#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    QXLog(@"search:%@",[searchController.searchBar.text lowercaseString]);
    QXGoodsModel *model = [[QXGoodsModel alloc] init];
    NSArray *models = [model fetchWithKeyword:[searchController.searchBar.text lowercaseString]];
    self.srvc.resultArray = [NSMutableArray arrayWithArray:models];
}












#pragma mark - QXSearchResultViewControllerDelegate
- (void)cancelKeyboard
{
    [self.searchController.searchBar resignFirstResponder];
}


- (void)selectModel:(id)model
{
    QXGoodsModel *goodsModel = (QXGoodsModel*)model;
    self.searchController.active = NO;
    if (self.type==Type_Display)
    {
        QXGoodsDetailViewController *vc = [[QXGoodsDetailViewController alloc] initWithGid:goodsModel.ID];
        vc.hidesBottomBarWhenPushed = YES;
        vc.templateType = TemplateType_Edit;
        [vc setSaveGoodsBlock:^(QXGoodsModel *goodsModel) {
            //保存
            ([goodsModel fetchModel])?[goodsModel refresh]:[goodsModel store];
            [self loadData:NO];
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (self.type==Type_Select)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedGoods:)])
        {
            [self.delegate selectedGoods:goodsModel];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
