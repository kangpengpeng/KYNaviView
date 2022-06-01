//
//  KYCellModel.h
//  KYPerformanceMonitor
//
//  Created by 康鹏鹏 on 2021/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KYCellModel : NSObject
@property (nonatomic, strong)UIImage *image01;
@property (nonatomic, strong)UIImage *image02;
@property (nonatomic, strong)UIImage *image03;
@property (nonatomic, copy)NSString *desc;

+ (instancetype)initWithImage01:(NSString *)imageName01 image02:(NSString *)imageName02 image03:(NSString *)image03 andDesc:(NSString *)desc;
@end

NS_ASSUME_NONNULL_END
