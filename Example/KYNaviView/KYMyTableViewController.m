//
//  KYMyTableViewController.m
//  KYNaviView_Example
//
//  Created by 康鹏鹏 on 2022/3/29.
//  Copyright © 2022 kangpengpeng. All rights reserved.
//

#import "KYMyTableViewController.h"
#import "KYFPSTestCell.h"

@interface KYMyTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArr;

@property (nonatomic, strong)UIScrollView *testSV;
@end

@implementation KYMyTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self setNaviTitle:@"列表数据"];
    [self.tableView registerClass:[KYFPSTestCell class] forCellReuseIdentifier:@"KYFPSTestCell"];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    self.tableView.backgroundColor = [UIColor purpleColor];
    // iOS11 以后，scrollView 顶部会默认预留状态栏高度，根据需要关闭此状态
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }

}
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        _tableView = table;
    }
    return _tableView;
}


#pragma mark: - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count/10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KYFPSTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KYFPSTestCell" forIndexPath:indexPath];
    /*
    KYFPSTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KYFPSTestCell"];
    if (cell == nil) {
        cell = [[KYFPSTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KYFPSTestCell"];
    }
     */
    KYCellModel *model = self.dataArr[indexPath.row];
    [cell setDataModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

#pragma mark: - 属性


- (NSArray *)dataArr {
    if (!_dataArr) {
        NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:1000];
        for (int i = 0; i < 100; i++) {
            KYCellModel *model = [KYCellModel initWithImage01:@"1" image02:@"2" image03:@"3" andDesc:[NSString stringWithFormat:@"index =====> %d", i]];
            [dataArr addObject:model];
        }
        _dataArr = dataArr;
    }
    return _dataArr;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
