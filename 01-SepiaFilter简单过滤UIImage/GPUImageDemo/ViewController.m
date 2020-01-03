//
//  ViewController.m
//  GPUImageDemo
//
//  Created by SeacenLiu on 2020/1/3.
//  Copyright © 2020 SeacenLiu. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage/GPUImage.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView* imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    [self filterHandle];
}

- (void)filterHandle {
    GPUImageFilter *filter = [[GPUImageSepiaFilter alloc] init];
    UIImage *image = [UIImage imageNamed:@"miku.png"];
    if (image) {
        self.imageView.image = [filter imageByFilteringImage:image];
    }
}


@end
