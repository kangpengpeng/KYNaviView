//
//  KYMyViewController.m
//  KYNaviView_Example
//
//  Created by 康鹏鹏 on 2022/3/14.
//  Copyright © 2022 kangpengpeng. All rights reserved.
//

#import "KYMyViewController.h"
#import "KYMyTableViewController.h"

@interface KYMyViewController ()

@end

@implementation KYMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"默认简洁版自定义导航栏";
    self.ky_didTouchTitle = ^(KYNaviContext * _Nonnull context) {
        NSLog(@"导航栏标题被点击！！！");
    };
    __weak typeof(self) weakSelf = self;
    self.ky_addCustomView = ^(KYNaviContext * _Nonnull context) {
        UIButton *rightItem = [[UIButton alloc] init];
        //rightItem.backgroundColor = [UIColor redColor];
        [rightItem setTitle:@"我的合同" forState:UIControlStateNormal];
        [rightItem setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        NSLog(@"*** %@", rightItem);
        [rightItem sizeToFit];
        CGFloat itemW = rightItem.frame.size.width;
        CGFloat itemH = rightItem.frame.size.height;
        CGFloat itemX = context.navigationView.frame.size.width - itemW - 20;
        CGFloat itemY = [weakSelf getStatusBarHeight] + ((context.navigationView.frame.size.height - [weakSelf getStatusBarHeight]) - itemH) / 2;
        rightItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
        [context.navigationView addSubview:rightItem];
    };
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    KYMyTableViewController *tbVC = [[KYMyTableViewController alloc] init];
//    [self.navigationController pushViewController:tbVC animated:YES];
//    [self setNaviTitle:@"djalfjaodfjaod"];
//}




@end
