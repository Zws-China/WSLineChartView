# WSLineChartView
折线图，支持放大缩小，横向定位放大,增加长按功能,y轴的值可以自己设置。采用贝塞尔曲线，核心绘图，支持大数据量。减少卡顿，左右滑动流畅


# PhotoShoot

![image](http://www.code4app.com/data/attachment/album/201912/18/160358jrq7kufhlwueqahr.39)
![image](http://www.code4app.com/data/attachment/album/201912/18/160411nbough6mlu0bhbm0.39)

# How To Use

```ruby

1.将WSLineChartView文件夹拖入工程中

#import "WSLineChartView.h"

NSMutableArray *xArray = [NSMutableArray array];
NSMutableArray *yArray = [NSMutableArray array];
for (NSInteger i = 0; i < 100; i++) {
    
    [xArray addObject:[NSString stringWithFormat:@"%ld",i]];
    [yArray addObject:[NSString stringWithFormat:@"%.2lf",20.0+arc4random_uniform(10)]];
    
}

//这里你可以计算出yArray的最大最小值。设置为曲线的最大最小值，这样画出来的线占据整个y轴高度。
//..........

WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-200) xTitleArray:xArray yValueArray:yArray yMax:40 yMin:10 yTypeName:@"高考成绩" xTypeName:@"考生号" unit:@"分"];
[self.view addSubview:wsLine];

喜欢的点个星。 (*^__^*)

```
