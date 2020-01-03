#  README
`GPUImageSepiaFilter`棕黑色滤镜的简单使用，将读取出来的`UIImage`进行滤镜处理

```
- (void)filterHandle {
    GPUImageFilter *filter = [[GPUImageSepiaFilter alloc] init];
    UIImage *image = [UIImage imageNamed:@"miku.png"];
    if (image) {
        self.imageView.image = [filter imageByFilteringImage:image];
    }
}
```

