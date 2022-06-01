//
//  KYBaseNaviViewController.h
//  MobileBank
//
//  Created by 康鹏鹏 on 2021/6/10.
//

#import <UIKit/UIKit.h>
#import "KYNavigationViewControllerDelegate.h"
#import "KYNavigationView.h"
#import "KYNaviContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface KYBaseNaviViewController : UIViewController<KYNavigationViewControllerDelegate>

/// 自定义导航栏控制器协议
@property (nonatomic, weak) id<KYNavigationViewControllerDelegate> navigationDelegate;

/// 控制器生命周期 viewWillAppear
@property (nonatomic, copy)void(^ky_viewWillAppear)(KYNaviContext *context);
/// 控制器生命周期 viewDidLoad
@property (nonatomic, copy)void(^ky_viewDidLoad)(KYNaviContext *context);
/// 控制器生命周期 viewWillDisappear
@property (nonatomic, copy)void(^ky_viewWillDisappear)(KYNaviContext *context);
/// 控制器生命周期 viewDidDisappear
@property (nonatomic, copy)void(^ky_viewDidDisappear)(KYNaviContext *context);
/// 是否允许返回按钮执行
@property (nonatomic, copy)BOOL(^ky_canPerformGoback)(KYNaviContext *context);
/// 返回按钮将要执行
@property (nonatomic, copy)void(^ky_willPerformGoback)(KYNaviContext *context);
/// 返回按钮已经执行
@property (nonatomic, copy)void(^ky_didPerformGoback)(KYNaviContext *context);

#pragma mark: - 通用/常用方法
/// 设置导航栏 title，也可以直接调用 self.title 赋值
/// @param title 导航栏标题
- (void)setNaviTitle:(NSString *)title;

/// 是否隐藏导航栏
/// @param isHidden 是否隐藏导航栏
- (void)hiddenNaviView:(BOOL)isHidden;

/// 设置导航栏背景颜色
/// @param color 颜色
- (void)setNaviBackgroundColor:(UIColor *)color;

/// 设置导航栏背景图片，默认 UIViewContentModeScaleToFill 拉伸铺满
/// @param image 图片对象
- (void)setNaviBackgroundImage:(UIImage *)image;

/// 设置导航栏背景图片
/// @param image 图片对象
/// @param contentMode 图片填充方式
- (void)setNaviBackgroundImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode;

/// 是否隐藏导航栏底部分割线
/// @param hidden 默认显示
- (void)hiddenNaviSeparatorLine:(BOOL)hidden;

/// 设置导航栏分割线颜色
/// @param color 颜色，默认 #F0F0F0
- (void)setNaviSeparatorLineColor:(UIColor *)color;

/// 获取状态栏高度
- (CGFloat)getStatusBarHeight;

/// 获取导航栏高度
- (CGFloat)getNavigationBarHeight;

/// 获取导航栏和状态栏总高度
- (CGFloat)getNaviBarAndStatusBarHeight;

/// 导航栏返回按钮响应方法
/// 子类直接调用该方法，不会走返回按钮的状态监听 KYNavigationViewDelegate 及 block
- (void)goback;


#pragma mark: - 返回按钮设置
/// 设置返回按钮图片
/// @param image 图片，图片显示状态默认 UIControlStateNormal 状态
- (void)setNaviBackBtnImage:(UIImage *)image;
/// 设置返回按钮图片
/// @param image 图片
/// @param state 图片显示状态
- (void)setNaviBackBtnImage:(UIImage *)image forState:(UIControlState)state;

/// 设置返回按钮背景图
/// @param image 图片，图片显示状态默认 UIControlStateNormal 状态
- (void)setNaviBackBtnBackgroundImage:(UIImage *)image;

/// 设置返回按钮背景图
/// @param image 图片
/// @param state 图片显示状态
- (void)setNaviBackBtnBackgroundImage:(UIImage *)image forState:(UIControlState)state;

/// 设置导航按钮标题
/// @param title 提示内容
- (void)setNaviBackBtnTitle:(NSString *)title;
/// 设置导航按钮标题和颜色
/// @param title 提示内容
/// @param color 标题颜色
- (void)setNaviBackBtnTitle:(NSString *)title color:(UIColor *)color;

/// 隐藏返回按钮
/// @param isHidden 是否隐藏返回按钮，默认 NO 不隐藏
- (void)hiddenNaviBackBtn:(BOOL)isHidden;

#pragma mark: - 添加右侧自定义按钮
/// 添加右侧自定义按钮
/// @param item 自定义视图
- (void)addNaviRightItem:(UIView *)item;

/// 批量添加右侧自定义按钮
/// @param items 自定义视图数组
- (void)addNaviRightItems:(NSArray<UIView *> *)items;


@end

NS_ASSUME_NONNULL_END
