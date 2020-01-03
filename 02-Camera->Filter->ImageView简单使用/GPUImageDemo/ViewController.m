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
#import "GPUImageSepiaFilter.h"

@interface ViewController ()
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageSepiaFilter *sepiaFilter;
@property (nonatomic, strong) GPUImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 初始化
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    self.sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    self.imageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.fillMode = kGPUImageFillModeStretch;
    [self.view addSubview:self.imageView];
    // 2. 响应链连接
    [self.videoCamera addTarget:self.sepiaFilter];
    [self.sepiaFilter addTarget:self.imageView];
    // 3. 相机开始工作
    [self.videoCamera startCameraCapture];
    // 4. 处理手机方向问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
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
