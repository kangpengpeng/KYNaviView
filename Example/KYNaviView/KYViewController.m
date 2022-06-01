//
//  KYViewController.m
//  KYNaviView
//
//  Created by kangpengpeng on 03/14/2022.
//  Copyright (c) 2022 kangpengpeng. All rights reserved.
//

#import "KYViewController.h"
#import <KYBaseNaviViewController.h>
#import "KYMyViewController.h"
#import "KYMyTableViewController.h"
#import "KYNoNaviViewController.h"

@interface KYViewController ()<KYNavigationViewControllerDelegate>

@end

@implementation KYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 说明：自定义导航控制器不支持绑定 storyboard
    // 这么用会导致 stroyboard 布局的 subviews 不能显示
    [self initNavigation];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self moreCase];
}

/// 初始化导航栏，常用设置
- (void)initNavigation {
    // 设置导航标题 或使用 [self setNaviTitle:@"xxx"];
    self.title = @"第一个自定义导航栏控制器";
    // 设置导航栏背景色
    [self setNaviBackgroundColor:[UIColor whiteColor]];
    // 设置导航栏背景图
    [self setNaviBackgroundImage:[UIImage imageNamed:@"test_image"]];
    // 是否隐藏分割线
    [self hiddenNaviSeparatorLine:NO];
    // 设置导航栏分割线颜色
    [self setNaviSeparatorLineColor:[UIColor redColor]];
    // 设置self.view 距离屏幕物理顶部偏移距离，隐藏导航栏该设置依然生效，请根据需要使用
    // 导航显示的情况下，默认偏移=状态栏高度+导航栏高度，此时零点在导航栏的左下角
    //[self hiddenNaviView:NO];
    //[self setEdgesTop:0];
    // 设置self.view 距离屏幕物理底部偏移距离，底部有tabbar等控件时，可以设置该属性
    [self setEdgesBottom:0];
    // 添加右侧按钮，最大支持3个，大于三个的部分不再显示
    UIButton *rightItem1 = [[UIButton alloc] init];
    [rightItem1 addTarget:self action:@selector(rightItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightItem1 setImage:[UIImage imageNamed:@"right_icon_1"] forState:UIControlStateNormal];
    [self addNaviRightItem:rightItem1];
    /*
    // 也可以使用数组添加右侧按钮，
    UIButton *rightItem2 = [[UIButton alloc] init];
    [rightItem2 setImage:[UIImage imageNamed:@"right_icon_2"] forState:UIControlStateNormal];
    UIButton *rightItem3 = [[UIButton alloc] init];
    [rightItem3 setImage:[UIImage imageNamed:@"right_icon_3"] forState:UIControlStateNormal];
    UIButton *rightItem4 = [[UIButton alloc] init];
    [rightItem4 setImage:[UIImage imageNamed:@"right_icon_3"] forState:UIControlStateNormal];
    [self addNaviRightItems:@[rightItem2, rightItem3, rightItem4]];
     */
    
    // 监听titleView的点击事件，可以用代理，也可以用block
    self.navigationDelegate = self;
    __weak typeof(self) weakSelf = self;
    self.ky_didTouchTitle = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"block ===> %@ 的 TitleView 被点击，title内容：%@", NSStringFromClass(weakSelf.class), weakSelf.title);
    };
}
- (void)rightItemAction:(id)sender {
    NSLog(@"自定义导航栏右侧下载按钮响应事件");
}

#pragma mark: - KYNavigationViewControllerDelegate
// 监听title 被点击
- (void)ky_navigationController:(KYBaseNaviViewController *)controller didTouchTitleView:(KYNaviContext *)context {
    NSLog(@"delegate ===> %@ 的 TitleView 被点击，title内容：%@", NSStringFromClass(self.class), controller.title);
}




#pragma mark: - 更多使用案例
- (void)moreCase {
    NSArray *caseArr = @[@{@"btnTitle": @"默认状态自定义导航栏", @"btnAction": @"case_01:"},
                         @{@"btnTitle": @"TableView列表", @"btnAction": @"case_02:"},
                         @{@"btnTitle": @"push前设置导航栏", @"btnAction": @"case_03:"}
    ];
    
    CGFloat space = 30;
    CGFloat btnX = 50;
    CGFloat btnW = self.view.frame.size.width - btnX * 2;
    CGFloat btnH = 60;
    for (int i = 0; i < caseArr.count; i++) {
        CGFloat btnY = (space * (i+1)) + (btnH * i);
        NSDictionary *btnInfo = caseArr[i];
        NSString *btnTitle = btnInfo[@"btnTitle"];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        [btn addTarget:self action:NSSelectorFromString(btnInfo[@"btnAction"]) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
}

- (void)case_01:(UIButton *)sender {
    KYMyViewController *myVC = [[KYMyViewController alloc] init];
    [self.navigationController pushViewController:myVC animated:YES];
    // 监听控制器状态
    myVC.ky_willPerformGoback = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"ky_willPerformGoback block -> %@", context);
    };
    myVC.ky_canPerformGoback = ^BOOL(KYNaviContext * _Nonnull context) {
        return YES;
    };
    myVC.ky_didPerformGoback = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"ky_didPerformGoback block -> %@", context);
    };
    myVC.ky_viewDidLoad = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"ky_viewDidLoad block");
    };
    myVC.ky_viewWillAppear = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"ky_viewWillAppear block");
    };
    myVC.ky_viewDidAppear = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"ky_viewDidAppear block");
    };

    myVC.ky_viewWillDisappear = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"ky_viewWillDisappear block");
    };
    myVC.ky_viewDidDisappear = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"ky_viewDidDisappear block");
    };
}

- (void)case_02:(UIButton *)sender {
    KYMyTableViewController *tbVC = [[KYMyTableViewController alloc] init];
    [self.navigationController pushViewController:tbVC animated:YES];
}

- (void)case_03:(UIButton *)sender {
    KYNoNaviViewController *noNaviVC = [[KYNoNaviViewController alloc] init];
    [noNaviVC hiddenNaviView:YES];
    [noNaviVC setEdgesTop:20];
    [self.navigationController pushViewController:noNaviVC animated:YES];
    
}
@end
