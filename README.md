# MJRefresh-Custom
> 一直有这样一个需求，在上拉加载更多时footer在tableView的最底部，在当没有更多数据时footer紧更tableView的最后一个Cell，而且不可以继续上拉加载更多。

## MJRefresh 默认有2宗模式
### Auto
1. 上拉一定距离不松手便可自动刷新（可关闭）
2. footer紧更tableView的最后一个Cell
3. 可点击自动加载
4. 当显示无数据时直接可看到无数据提示（这个体验较好）
5. 其他未知

### Back

1. 上拉必须松手才可刷新
2. footer紧更tableView的底部
3. 不可点击自动加载（因为永远在tableView的底部）
4. 当显示无数据时需上拉才可看到无数据提示（这个体验不是特别好）
5. 其他未知

## 我需要的效果

1. 上拉时和Back一样的效果
2. 当显示无数据时和Auto一样的效果

## 之前的解决方案

默认使用Back，在无数据时清空footer，自己加一个无数据View上去，（tableView可使用tableViewFooterView做，至于其他的目测没有太好的解决方案，而且感觉各种烦，不就是一个空数据嘛！）

## 解决方案
>说多了多少泪，如果全部自定义那都不是事，暂时不考虑完全自己写Refresh，我们使用Auto加Back来组合使用吧，具体简单封装了下。

