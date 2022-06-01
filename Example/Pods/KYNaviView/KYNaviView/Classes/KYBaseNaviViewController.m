//
//  KYBaseNaviViewController.m
//  MobileBank
//
//  Created by 康鹏鹏 on 2021/6/10.
//

#import "KYBaseNaviViewController.h"
#import "KYControllerView.h"
#import "KYNaviTool.h"

@interface KYBaseNaviViewController ()
@property (nonatomic, strong) KYNavigationView *naviView;
/// 修改self.view 的指向，因为导航栏超出self.view 区域不可响应，为了实现超出响应事件
@property (nonatomic, strong) KYControllerView *controllerView;
/// 控制器上下问，给外部传递信息使用
@property (nonatomic, strong) KYNaviContext *naviContext;

@end

@implementation KYBaseNaviViewController {
    BOOL _hasLoadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.ky_viewDidLoad) {
        self.ky_viewDidLoad(self.naviContext);
    }
    _hasLoadView = YES;
    // 隐藏系统导航栏
    self.navigationController.navigationBar.hidden = YES;
    [self setupNaviView];
//    [self.view layoutIfNeeded];
    
//    CGFloat statusAndNaviHeight = [KYNaviTool getStatusBarHeight]+[KYNaviTool getNavigationBarHeight];
//    CGFloat viewY = self.naviView.isHidden ? 0 : statusAndNaviHeight;
//    self.view.frame = CGRectMake(0, viewY, self.view.frame.size.width, self.view.frame.size.height - viewY);
}

#pragma mark: - 通用/常用方法
- (void)setTitle:(NSString *)title {
    [self setNaviTitle:title];
}
- (void)setNaviTitle:(NSString *)title {
    [self.naviView setTitle:title];
}

- (void)hiddenNaviView:(BOOL)isHidden {
    self.naviView.hidden = isHidden;
    // 触发 viewWillLayoutSubviews 立即更新 self.view.frame
    // 适配 push 之前对 naviView 的操作
    if (_hasLoadView) {
        [self.view layoutIfNeeded];
    }
}

- (void)setNaviBackgroundColor:(UIColor *)color {
    if (color == nil) return;
    // 背景透明，导航栏下的分割线默认也要设置成透明
    if (color == [UIColor clearColor]) {
        [self.naviView setSeparatorLineColor:color];
    }
    self.naviView.backgroundColor = color;
}
/// 设置导航栏背景图片
/// @param image 图片
- (void)setNaviBackgroundImage:(UIImage *)image {
    if (image == nil) return;
    [self setNaviBackgroundImage:image contentMode:UIViewContentModeScaleToFill];
}
- (void)setNaviBackgroundImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    if (image == nil) return;
    [self.naviView setBackgroundImage:image contentMode:contentMode];
}

/// 是否隐藏导航栏底部分割线
/// @param hidden 默认显示
- (void)hiddenNaviSeparatorLine:(BOOL)hidden {
    [self.naviView hiddenSeparatorLine:hidden];
}
/// 设置导航栏分割线颜色
/// @param color 颜色，默认 #F0F0F0
- (void)setNaviSeparatorLineColor:(UIColor *)color {
    if (color == nil) return;
    [self.naviView setSeparatorLineColor:color];
}
/** 获取状态栏高度 */
- (CGFloat)getStatusBarHeight {
    return [KYNaviTool getStatusBarHeight];
}

/** 获取导航栏高度 */
- (CGFloat)getNavigationBarHeight {
    return [KYNaviTool getNavigationBarHeight];
}

/** 获取导航栏和状态栏总高度 */
- (CGFloat)getNaviBarAndStatusBarHeight {
    return [self getStatusBarHeight] + [self getNavigationBarHeight];
}

- (void)goback {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark: - 返回按钮设置
/// 设置返回按钮图片
/// @param image 图片，图片显示状态默认 UIControlStateNormal 状态
- (void)setNaviBackBtnImage:(UIImage *)image {
    [self setNaviBackBtnImage:image forState:UIControlStateNormal];
}
/// 设置返回按钮图片
/// @param image 图片
/// @param state 图片显示状态
- (void)setNaviBackBtnImage:(UIImage *)image forState:(UIControlState)state
{
    [self.naviView setBackBtnImage:image forState:state];
}
/// 设置返回按钮背景图
/// @param image 图片，图片显示状态默认 UIControlStateNormal 状态
- (void)setNaviBackBtnBackgroundImage:(UIImage *)image {
    [self setNaviBackBtnBackgroundImage:image forState:UIControlStateNormal];
}

/// 设置返回按钮背景图
/// @param image 图片
/// @param state 图片显示状态
- (void)setNaviBackBtnBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.naviView setBackBtnBackgroundImage:image forState:state];
}

/// 设置返回按钮标题
/// @param title 提示内容
- (void)setNaviBackBtnTitle:(NSString *)title {
    [self.naviView setBackBtnTitle:title];
}
/// 设置导航按钮标题和颜色
/// @param title 提示内容
/// @param color 标题颜色
- (void)setNaviBackBtnTitle:(NSString *)title color:(UIColor *)color {
    [self.naviView setBackBtnTitle:title color:color];
}

/// 隐藏返回按钮
/// @param isHidden 是否隐藏返回按钮，默认 NO 不隐藏
- (void)hiddenNaviBackBtn:(BOOL)isHidden {
    [self.naviView hiddenBackBtn:isHidden];
}

#pragma mark: - 添加右侧自定义按钮
/// 添加右侧自定义按钮
/// @param item 自定义视图
- (void)addNaviRightItem:(UIView *)item {
    [self.naviView addRightItem:item];
    //[self.naviConfig.naviRightItems addObject:item];
}
/// 批量添加右侧自定义按钮
/// @param items 自定义视图数组
- (void)addNaviRightItems:(NSArray<UIView *> *)items {
    if (items == nil) return;
    //[self.naviConfig.naviRightItems addObjectsFromArray:items];
    [self addNaviRightItems:items];
}




#pragma mark: - 私有方法
- (void)gobackBtnAction:(UIButton *)button {
    BOOL canGobackBydelegate = YES;
    if (self.navigationDelegate && [self.navigationDelegate respondsToSelector:@selector(ky_navigationController:canPerformGoback:)]) {
        canGobackBydelegate = [self.navigationDelegate ky_navigationController:self canPerformGoback:self.naviContext];
    }
    if (canGobackBydelegate == NO) return;
    BOOL canGobackByblock = YES;
    if (self.ky_canPerformGoback) {
        canGobackByblock = self.ky_canPerformGoback(self.naviContext);
    }
    if (canGobackByblock == NO) return;
    
    if (self.navigationDelegate && [self.navigationDelegate respondsToSelector:@selector(ky_navigationController:willPerformGoback:)]) {
        [self.navigationDelegate ky_navigationController:self willPerformGoback:self.naviContext];
    }
    if (self.ky_willPerformGoback) {
        self.ky_willPerformGoback(self.naviContext);
    }
    [self goback];
    if (self.navigationDelegate && [self respondsToSelector:@selector(ky_navigationController:didPerformGoback:)]) {
        [self.navigationDelegate ky_navigationController:self didPerformGoback:self.naviContext];
    }
    if (self.ky_didPerformGoback) {
        self.ky_didPerformGoback(self.naviContext);
    }
}

#pragma mark: - UI 布局
//- (void)viewDidLayoutSubviews
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // 修正 controller.view.frame，使其零点坐标在导航栏下方
    CGFloat statusAndNaviHeight = [KYNaviTool getStatusBarHeight]+[KYNaviTool getNavigationBarHeight];
    CGFloat viewY = self.naviView.isHidden ? 0 : statusAndNaviHeight;
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewH = [UIScreen mainScreen].bounds.size.height - viewY;
    self.view.frame = CGRectMake(0, viewY, viewW, viewH);
    NSLog(@"self.view.height layout ==> %f", self.view.frame.size.height);
}

- (void)setupNaviView {
    [self.navigationController.navigationBar setHidden:YES];
    CGFloat statusAndNaviHeight = [KYNaviTool getStatusBarHeight] + [KYNaviTool getNavigationBarHeight];
    
    // 替换controller.view 指针，
    self.controllerView.frame = self.view.frame;
    CGFloat viewY = self.naviView.isHidden ? 0 : statusAndNaviHeight;
    self.controllerView.frame = CGRectMake(0, viewY, self.view.frame.size.width, self.view.frame.size.height - viewY);
    self.view.backgroundColor = [UIColor whiteColor];
    self.view = self.controllerView;
    
    self.naviView.frame = CGRectMake(0, -statusAndNaviHeight, self.view.frame.size.width, statusAndNaviHeight);
    [self.naviView gobackBtnAddTarget:self action:@selector(gobackBtnAction:)];
    [self.naviView addToController:self];
    [self.view bringSubviewToFront:(UIView *)self.naviView];
    
}




#pragma mark: - 属性
/// 导航栏视图
- (KYNavigationView *)naviView {
    if (!_naviView) {
        _naviView = [[KYNavigationView alloc] init];
    }
    return _naviView;
}
/// 控制器上的View
- (KYControllerView *)controllerView {
    if (!_controllerView) {
        _controllerView = [[KYControllerView alloc] init];
        _controllerView.backgroundColor = [UIColor whiteColor];
    }
    return _controllerView;
}
- (KYNaviContext *)naviContext {
    if (!_naviContext) {
        _naviContext = [[KYNaviContext alloc] init];
        _naviContext.controller = self;
        _naviContext.navigationView = self.naviView;
    }
    return _naviContext;
}


#pragma mark: - 控制器周期方法block
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.ky_viewWillDisappear) {
        self.ky_viewWillAppear(self.naviContext);
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.ky_viewWillDisappear) {
        self.ky_viewWillDisappear(self.naviContext);
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.ky_viewDidDisappear) {
        self.ky_viewDidDisappear(self.naviContext);
    }
    // self.controllerView 不会导致内存泄露
    // self.controllerView = nil;
    self.naviContext = nil;
}


- (void)dealloc {
    NSLog(@"****************");
}


@end
