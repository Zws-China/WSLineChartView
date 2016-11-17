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
    self.view.backgroundColor = [UIColor colorWithRed:85.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:1.0f];

    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 50; i++) {
        
        [xArray addObject:[NSString stringWithFormat:@"%.1f",3+0.1*i]];
        [yArray addObject:[NSString stringWithFormat:@"%.2lf",20.0+arc4random_uniform(10)]];
        
    }
    
    
    WSLineChartView *wsLine = [[WSLineChartView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 400) xTitleArray:xArray yValueArray:yArray yMax:100 yMin:0];
    [self.view addSubview:wsLine];
    
}






@end
