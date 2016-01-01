//
//  QXScanCodeViewController.m
//  WeBusiness
//
//  Created by 亓鑫 on 16/1/2.
//  Copyright © 2016年 亓鑫. All rights reserved.
//

#import "QXScanCodeViewController.h"
@import AVFoundation;
@interface QXScanCodeViewController ()
<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;
@end

@implementation QXScanCodeViewController


- (BOOL)checkOpenVideoState
{
    // ios7以上 authStatus == AVAuthorizationStatusAuthorized
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusNotDetermined)
    {
        // AVAuthorizationStatusNotDetermined 用户尚未做出了选择这个应用程序的问候
        // 表示用户还没选择过，此时要给用户一个使用的机会
        return YES;
    }
    else if (authStatus == AVAuthorizationStatusRestricted)
    {
        // AVAuthorizationStatusRestricted 此应用程序没有被授权访问的照片数据。可能是家长控制权限
        return NO;
    }
    else if (authStatus == AVAuthorizationStatusDenied)
    {
        // AVAuthorizationStatusDenied 用户已经明确否认了这一照片数据的应用程序访问
        return NO;
    }
    else if (authStatus == AVAuthorizationStatusAuthorized)
    {
        // AVAuthorizationStatusAuthorized 用户已授权应用访问照片数据
        return YES;
    }
    else
    {
        // 默认情况下，还是返回YES，这样就算有崩溃问题，但是至少能给用户一个进入界面的机会
        return YES;
    }
}





- (void)onClickBack:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    if (![self checkOpenVideoState])
    {
        ALERT(@"相机权限没有打开,设置->隐私->相机", @"确定");
    }
    else
    {
        // Device
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Input
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        // Output
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // Session
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetPhoto];
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput:self.output];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes = _output.availableMetadataObjectTypes;
        // Preview
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame = CGRectMake(0, self.view.bounds.size.height*0.5-100, self.view.bounds.size.width, 200);
        [self.view.layer insertSublayer:_preview atIndex:0];
        
        // Start
        [_session startRunning];
    }
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(20, 20, 40, 40);
    [cancelButton setTitle:@"关闭" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(onClickBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(50, self.view.bounds.size.height*0.5, self.view.bounds.size.width-100, ONE_PIXEL_VALUE)];
    line.backgroundColor = RGBA(0, 256, 128, 1);
    [self.view addSubview:line];
    
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //2015-09-16 qixin 增加每次进入时自动激活扫码状态
    if (![_session isRunning])
    {
        [_session startRunning];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //2015-09-16 qixin 增加离开时自动停止扫码状态
    if ([_session isRunning])
    {
        [_session stopRunning];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}














#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        
        //播放音效
        static SystemSoundID soundIDTest = 0;
        NSString * path = [[NSBundle mainBundle] pathForResource:@"scan" ofType:@"wav"];
        if (path)
        {
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&soundIDTest);
            AudioServicesPlaySystemSound(soundIDTest);
        }

        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        //TODO:各种判断,看跳哪个模板展示,目前暂时只显示文本模板.....
        if (self.delegate && [self.delegate respondsToSelector:@selector(scanCodeFinish:code:)])
        {
            [self.delegate scanCodeFinish:self code:stringValue];
        }        
    }
}



@end
