//
//  ViewController.m
//  GPUImageDemo
//
//  Created by SeacenLiu on 2020/1/3.
//  Copyright © 2020 SeacenLiu. All rights reserved.
//

#import "ViewController.h"
#import "GPUImageView.h"
#import "GPUImageVideoCamera.h"
#import "GPUImageBeautifyFilter.h"
#import "UIView+frame.h"

@interface ViewController ()
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageBeautifyFilter *beautifyFilter;
@property (weak, nonatomic) IBOutlet GPUImageView *imageView;

@property (nonatomic, assign) BOOL enableBeautify;


@property (nonatomic, strong) UISlider *buffingSlider;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 初始化配置
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
    self.imageView.fillMode = kGPUImageFillModeStretch;
    // 2. 响应链连接
    [self relaodResponseChain];
    // 3. 相机开始工作
    [self.videoCamera startCameraCapture];
    // 4. 处理手机方向问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)relaodResponseChain {
    [self.videoCamera removeAllTargets];
    [self.beautifyFilter removeAllTargets];
    if (!_enableBeautify) {
        [self.videoCamera addTarget:self.imageView];
    } else {
        [self.videoCamera addTarget:self.beautifyFilter];
        [self.beautifyFilter addTarget:self.imageView];
    }
}

- (IBAction)beautifySwitchClick:(UISwitch*)sender {
    _enableBeautify = sender.on;
    [self relaodResponseChain];
}

- (IBAction)buffingSliderAction:(UISlider*)sender {
    [self.beautifyFilter setSmoothIntensity:sender.value];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    self.videoCamera.outputImageOrientation = orientation;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.imageView.frame = self.view.bounds;
}

@end
