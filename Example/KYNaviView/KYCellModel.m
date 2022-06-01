//
//  KYCellModel.m
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/11/30.
//

#import "KYCellModel.h"

@implementation KYCellModel

+ (instancetype)initWithImage01:(NSString *)imageName01 image02:(NSString *)imageName02 image03:(NSString *)imageName03 andDesc:(nonnull NSString *)desc {
    KYCellModel *model = [[KYCellModel alloc] init];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:imageName01 ofType:@"jpeg"];
    model.image01 = [UIImage imageWithContentsOfFile:path1];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:imageName02 ofType:@"jpeg"];
    model.image02 = [UIImage imageWithContentsOfFile:path2];
    NSString *path3 = [[NSBundle mainBundle] pathForResource:imageName03 ofType:@"jpeg"];
    model.image03 = [UIImage imageWithContentsOfFile:path3];
    model.desc = desc;
    return model;
}
@end
