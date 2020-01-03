#import "GPUImageOutput.h"
#import "GPUImageFilter.h"

/**
 * GPUImageFilterGroup是多个filter的集合，
 * terminalFilter为最终的filter，initialFilters为filter数组。
 * GPUImageFilterGroup本身不绘制图像，
 * 对GPUImageFilterGroup添加删除Target操作的操作都会转为terminalFilter的操作
 */
@interface GPUImageFilterGroup : GPUImageOutput <GPUImageInput>
{
    NSMutableArray *filters;
    BOOL isEndProcessing;
}

@property(readwrite, nonatomic, strong) GPUImageOutput<GPUImageInput> *terminalFilter;
@property(readwrite, nonatomic, strong) NSArray *initialFilters;
@property(readwrite, nonatomic, strong) GPUImageOutput<GPUImageInput> *inputFilterToIgnoreForUpdates; 

// Filter management
- (void)addFilter:(GPUImageOutput<GPUImageInput> *)newFilter;
- (GPUImageOutput<GPUImageInput> *)filterAtIndex:(NSUInteger)filterIndex;
- (NSUInteger)filterCount;

@end
