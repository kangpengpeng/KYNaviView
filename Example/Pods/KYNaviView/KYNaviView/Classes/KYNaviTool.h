//
//  KYNaviTool.h
//  KYNaviView
//
//  Created by 康鹏鹏 on 2022/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KYNaviTool : NSObject

/// 获取状态栏高度
+ (CGFloat)getStatusBarHeight;

/// 获取导航栏高度
+ (CGFloat)getNavigationBarHeight;

@end

NS_ASSUME_NONNULL_END
