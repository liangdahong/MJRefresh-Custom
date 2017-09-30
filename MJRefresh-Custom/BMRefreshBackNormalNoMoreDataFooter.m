//
//  BMRefreshBackNormalNoMoreDataFooter.m
//  MJRefresh-Custom
//
//  Created by ___liangdahong on 2017/9/30.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMRefreshBackNormalNoMoreDataFooter.h"
#import "MJRefreshAutoFooter.h"

@interface BMRefreshAutoNormalNoMoreDataFooter : MJRefreshAutoFooter

@property (strong, nonatomic) UIView *bottomNoDataView; ///< bottomNoDataView

@end

@implementation BMRefreshAutoNormalNoMoreDataFooter

- (void)setBottomNoDataView:(UIView *)bottomNoDataView {
    // 删除旧View
    if (_bottomNoDataView) {
        [_bottomNoDataView removeFromSuperview];
    }
    _bottomNoDataView = bottomNoDataView;

    // 添加新值
    if (bottomNoDataView) {
        [self addSubview:_bottomNoDataView];
    }
}

#pragma mark - 重写父类的方法

- (void)prepare {
    [super prepare];
    self.automaticallyHidden = YES;
}

- (void)placeSubviews {
    [super placeSubviews];
    // 状态标签
    self.bottomNoDataView.frame = self.bounds;
}

- (void)resetNoMoreData {
    [super resetNoMoreData];
    BMRefreshBackNormalNoMoreDataFooter *footer = [BMRefreshBackNormalNoMoreDataFooter footerWithRefreshingBlock:self.refreshingBlock];
    footer.bottomNoDataView = self.bottomNoDataView;
    self.scrollView.mj_footer = footer;
}

@end

@implementation BMRefreshBackNormalNoMoreDataFooter

- (void)prepare {
    [super prepare];
    self.automaticallyHidden = YES;
    
    if (!_bottomNoDataView) {
        UILabel *bottomNoDataView = [UILabel new];
        bottomNoDataView.text = @"没有更多数据了噢~";
        bottomNoDataView.textAlignment = NSTextAlignmentCenter;
        bottomNoDataView.font = [UIFont systemFontOfSize:14];
        _bottomNoDataView = bottomNoDataView;
    }
}

- (void)placeSubviews {
    [super placeSubviews];
    self.bottomNoDataView.frame = self.bounds;
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    if (state == MJRefreshStateNoMoreData) {
        BMRefreshAutoNormalNoMoreDataFooter *footer = [BMRefreshAutoNormalNoMoreDataFooter footerWithRefreshingBlock:self.refreshingBlock];
        footer.bottomNoDataView = self.bottomNoDataView;
        footer.state = MJRefreshStateNoMoreData;
        self.scrollView.mj_footer = footer;
    }
}

@end
