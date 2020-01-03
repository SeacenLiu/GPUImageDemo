#  README
响应链：`videoCamera` -> `sepiaFilter` -> `imageView`

```
[self.videoCamera addTarget:self.sepiaFilter];
[self.sepiaFilter addTarget:self.imageView];
```

