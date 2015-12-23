//
//  QXGoodsDetailViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 15/12/22.
//  Copyright © 2015年 亓鑫. All rights reserved.
//

#import "QXGoodsDetailViewController.h"
#import "QXGoodsModel.h"
#import "QXGoodsModel+Utils.h"

#import "QXInputStringViewController.h"
#import "QXGoodsDetailTextCell.h"

#import "QXGoodsDetailTableViewHeaderView.h"

#import "UIImage+Utils.h"
#import "QXImageCompressUtil.h"

#import "QXGoodsDetailImageItemCell.h"

#import "QXShareViewController.h"

static NSString *identifier = @"QXGoodsDetailTextCell";

@interface QXGoodsDetailViewController ()
<UITableViewDataSource,
UITableViewDelegate,
QXGoodsDetailTableViewHeaderViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (copy, nonatomic) NSString *gid;
@property (strong, nonatomic) QXGoodsModel *goodsModel;
@property (strong, nonatomic) NSArray *headerTitles;
@property (strong, nonatomic) QXGoodsDetailTableViewHeaderView *imgHeadView;
@end

@implementation QXGoodsDetailViewController


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



- (void)openImagePicker:(UIImagePickerControllerSourceType)type
{
    if ([UIImagePickerController isSourceTypeAvailable:type])
    {
        if (type == UIImagePickerControllerSourceTypePhotoLibrary)
        {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.sourceType = type;
            imgPicker.delegate = self;
            [self presentViewController:imgPicker animated:YES completion:NULL];
        }
        else if (type == UIImagePickerControllerSourceTypeCamera)
        {
            UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
            imgPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
            imgPicker.sourceType = type;
            imgPicker.delegate = self;
            imgPicker.showsCameraControls = YES;
            imgPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
            [self presentViewController:imgPicker animated:YES completion:nil];
        }
    }
    else
    {
        ALERT(@"授权失败或不可用", nil);
    }
}



- (void)saveModel
{
    if (!VALID_STRING(self.goodsModel.name))
    {
        self.goodsModel.name = @"未命名";
    }
    if (self.saveGoodsBlock)
    {
        self.saveGoodsBlock(self.goodsModel);
    }
}




- (void)onBackClick:(UIBarButtonItem*)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)onShareClick:(UIBarButtonItem*)sender
{
    QXShareViewController *vc = [[QXShareViewController alloc] initWithGoodsModel:self.goodsModel];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)loadData
{
    if (self.templateType==TemplateType_Display)
    {
        QXGoodsModel *goodsModel = [[QXGoodsModel alloc] init];
        goodsModel.ID = self.gid;
        self.goodsModel = [goodsModel fetchModel];
    }
    else
    {
        self.goodsModel = [[QXGoodsModel alloc] init];
    }
}

- (void)loadUI
{
    self.headerTitles = @[@"名称",@"进价",@"单价",@"代理价",@"友情价",@"数量",@"描述",@"备注"];
    self.title = (self.templateType==TemplateType_Display)?@"编辑商品":@"添加商品";
    if (self.templateType==TemplateType_Add)
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onBackClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    else
    {
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(onShareClick:)];
        self.navigationItem.rightBarButtonItem = shareItem;
    }
    
    //Table
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[QXGoodsDetailTextCell class] forCellReuseIdentifier:identifier];
    
    
    //Header
    self.imgHeadView = [[QXGoodsDetailTableViewHeaderView alloc] init];
    self.imgHeadView.delegate = self;
    self.imgHeadView.picID = self.goodsModel.picID;
    self.tableView.tableHeaderView = self.imgHeadView;

    //Footer
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self loadUI];
}



- (instancetype)initWithGid:(NSString*)gid
{
    self = [super init];
    if (self)
    {
        self.gid = gid;
    }
    return self;
}




#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.headerTitles.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.headerTitles[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QXGoodsDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0)//商品名
    {
        cell.titleLabel.text = self.goodsModel.name;
    }
    else if (indexPath.section==1)//进价
    {
        cell.titleLabel.text = [self.goodsModel costPriceToString];
    }
    else if (indexPath.section==2)//零售价
    {
        cell.titleLabel.text = [self.goodsModel retailPriceToString];
    }
    else if (indexPath.section==3)//代理价
    {
        cell.titleLabel.text = [self.goodsModel delegatePriceToString];
    }
    else if (indexPath.section==4)//友情价
    {
        cell.titleLabel.text = [self.goodsModel friendPriceToString];
    }
    else if (indexPath.section==5)//数量
    {
        cell.titleLabel.text = [self.goodsModel countToString];
    }
    else if (indexPath.section==6)//描述
    {
        cell.titleLabel.text = self.goodsModel.descs;
    }
    else if (indexPath.section==7)//备注
    {
        cell.titleLabel.text = self.goodsModel.remark;
    }
    return cell;
}







#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QXInputStringViewController *inputStringViewController = [[QXInputStringViewController alloc] init];
    if (indexPath.section==0)//商品名
    {
        inputStringViewController.placeHolder = self.goodsModel.name;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.name = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==1)//进价
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel costPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.costPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==2)//零售
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel retailPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.retailPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==3)//代理
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel delegatePriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.delegatePrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==4)//友情
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel friendPriceToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.friendPrice = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==5)//数量
    {
        inputStringViewController.keyboardType = UIKeyboardTypeDecimalPad;
        inputStringViewController.placeHolder = [self.goodsModel countToString];
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.count = [string floatValue];
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==6)//描述
    {
        inputStringViewController.placeHolder = self.goodsModel.descs;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.descs = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
    if (indexPath.section==7)//备注
    {
        inputStringViewController.placeHolder = self.goodsModel.remark;
        [self.navigationController pushViewController:inputStringViewController animated:YES];
        [inputStringViewController setEditDoneBlock:^(NSString*string){
            self.goodsModel.remark = string;
            [self.tableView beginUpdates];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
            [self saveModel];
        }];
    }
}


















#pragma mark - QXGoodsDetailTableViewHeaderViewDelegate
- (void)headerView:(QXGoodsDetailTableViewHeaderView*)headerView isAddImage:(BOOL)isAdd picID:(NSString*)picID;
{
    if (isAdd)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"添加图片" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"照片"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self openImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
                                                        }];
        [alertController addAction:action0];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            [self openImagePicker:UIImagePickerControllerSourceTypeCamera];
                                                        }];
        [alertController addAction:action1];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                        }];
        [alertController addAction:action2];
        [self presentViewController:alertController animated:YES completion:NULL];
    }
}


- (void)headerView:(QXGoodsDetailTableViewHeaderView*)headerView longPressPicID:(NSString*)picID longPressCell:(QXGoodsDetailImageItemCell*)cell;
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:picID preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"删除"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [UIImage removeCacheWithID:picID];
                                                        [self.goodsModel removePicID:picID];
                                                        self.imgHeadView.picID = self.goodsModel.picID;
                                                        [self saveModel];
                                                    }];
    [alertController addAction:action0];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"保存到相册"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        UIImage *image = [UIImage imageWithPicID:picID];
                                                        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
                                                    }];
    [alertController addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                    }];
    [alertController addAction:action2];
    [self presentViewController:alertController animated:YES completion:NULL];
}











#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *picID = [[NSUUID UUID] UUIDString];
    [self.goodsModel addPicID:picID];
    self.imgHeadView.picID = self.goodsModel.picID;
    [self saveModel];
    
    //原始图
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //缩略图
    UIImage *thumbnail = [QXImageCompressUtil imageWithImageSimple:originalImage width:THUMBNAIL_WIDTH];
    [thumbnail saveWithID:STR_FORMAT(@"%@_s",picID)];
    //压缩图
    UIImage *compressImage = [QXImageCompressUtil imageWithImageSimple:originalImage width:COMPRESS_WIDTH];
    [compressImage saveWithID:picID];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
