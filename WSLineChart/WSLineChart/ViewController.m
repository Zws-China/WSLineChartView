//
//  ViewController.m
//  WSLineChart
//
//  Created by iMac on 16/11/14.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "ViewController.h"
#import "WSLineChartView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

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
    
}






@end
