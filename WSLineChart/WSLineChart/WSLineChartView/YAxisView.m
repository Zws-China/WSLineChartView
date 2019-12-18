//
//  yAxisView.m
//  3333
//
//  Created by iMac on 16/11/10.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "YAxisView.h"
#define topMargin 50   // 为顶部留出的空白
#define xAxisTextGap 5 //x轴文字与坐标轴间隙
#define numberOfYAxisElements 5 // y轴分为几段
#define kChartLineColor         [UIColor grayColor]
#define kChartTextColor         [UIColor blackColor]


@implementation YAxisView

- (id)initWithFrame:(CGRect)frame yMax:(CGFloat)yMax yMin:(CGFloat)yMin {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 计算坐标轴的位置以及大小
        NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:10]};
        CGSize labelSize = [@"22-22\r\n22:22" sizeWithAttributes:attr];
        // 垂直坐标轴
        UIView *separate = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-1, 0, 1, self.frame.size.height - labelSize.height - xAxisTextGap)];
        separate.backgroundColor = kChartLineColor;
        [self addSubview:separate];

    
        // Label做占据的高度
        CGFloat allLabelHeight = self.frame.size.height - xAxisTextGap - labelSize.height;
        // Label之间的间隙
        CGFloat labelMargin = (allLabelHeight - topMargin) / numberOfYAxisElements;
        
        // 添加Label
        for (int i = 0; i < numberOfYAxisElements + 1; i++) {
            UILabel *label = [[UILabel alloc] init];
            double avgValue = (yMax - yMin) / numberOfYAxisElements;
            
            double value = yMin + avgValue * i;
            
            if (value >= 1000000) {
                label.text = [NSString stringWithFormat:@"%.0f万", value/10000.0];
            }
            else {
                // 判断是不是小数
                if ([self isPureFloat:value]) {
                    label.text = [NSString stringWithFormat:@"%.2f", value];
                }
                else {
                    label.text = [NSString stringWithFormat:@"%.0f", value];
                }
            }
            
            label.textAlignment = NSTextAlignmentRight;// UITextAlignmentRight;
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = kChartTextColor;
            label.frame = CGRectMake(0, allLabelHeight - labelMargin* i - labelSize.height/2, self.frame.size.width - 1 - 5, labelSize.height);

            [self addSubview:label];
        }

        
        
    }
    return self;
}

// 判断是小数还是整数
- (BOOL)isPureFloat:(double)num
{
    int i = num;
    
    double result = num - i;
    
    // 当不等于0时，是小数
    return result != 0;
}


@end
