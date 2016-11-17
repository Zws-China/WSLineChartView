# WSLineChartView
折线图，支持放大缩小，横向定位放大,增加长按功能,y轴的值可以自己设置。采用贝塞尔曲线，核心绘图，支持大数据量。减少卡顿，左右滑动流畅


# PhotoShoot
![image](https://github.com/Zws-China/.../blob/master/WSLine.gif)


# How To Use

```ruby

1.将WSLineChartView文件夹拖入工程中

#import "WSLineChartView.h"

NSMutableArray *xArray = [NSMutableArray array];
NSMutableArray *yArray = [NSMutableArray array];
for (NSInteger i = 0; i < 50; i++) {

    [xArray addObject:[NSString stringWithFormat:@"%.1f",3+0.1*i]];
    [yArray addObject:[NSString stringWithFormat:@"%.2lf",20.0+arc4random_uniform(10)]];

}


WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 400) xTitleArray:xArray yValueArray:yArray yMax:100 yMin:0];
[self.view addSubview:wsLine];

喜欢的点个星。 (*^__^*)

```