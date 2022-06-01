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
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    KYMyTableViewController *tbVC = [[KYMyTableViewController alloc] init];
//    [self.navigationController pushViewController:tbVC animated:YES];
//    [self setNaviTitle:@"djalfjaodfjaod"];
//}




@end
