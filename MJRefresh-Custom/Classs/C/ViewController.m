//
//  ViewController.m
//  MJRefresh-Custom
//
//  Created by ___liangdahong on 2017/9/28.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "ViewController.h"
#import "MJRefreshNormalHeader.h"
#import "BMRefreshBackNormalNoMoreDataFooter.h"
#import "BMProductSearchBottomNoDataView.h"
#import "BMBottomNoDataView1.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger count; ///< <#Description#>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.tableFooterView = [UIView new];
    __weak typeof(self) weakSelf = self;
    BMRefreshBackNormalNoMoreDataFooter *footer = [BMRefreshBackNormalNoMoreDataFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) self = weakSelf;
            if (arc4random_uniform(2)) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                self.count += 10;
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView reloadData];
        });
    }];
    
    if (arc4random_uniform(2)) {
        footer.bottomNoDataView = [[[NSBundle mainBundle] loadNibNamed:@"BMProductSearchBottomNoDataView" owner:nil options:nil] firstObject];
        self.tableView.mj_footer = footer;
    } else {
        footer.bottomNoDataView = [[[NSBundle mainBundle] loadNibNamed:@"BMBottomNoDataView1" owner:nil options:nil] firstObject];
        self.tableView.mj_footer = footer;
    }

    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) self = weakSelf;
            [self.tableView.mj_footer resetNoMoreData];
            [self.tableView.mj_header endRefreshing];
            self.count = 10;
            if (arc4random_uniform(5) == 0) {
                self.count = 0;
            }
            [self.tableView reloadData];
        });
    }];

    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        self.count = 10;
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"c";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = indexPath.description;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
