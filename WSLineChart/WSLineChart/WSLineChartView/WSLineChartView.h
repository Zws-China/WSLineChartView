//
//  WSLineView.h
//  3333
//
//  Created by iMac on 16/11/10.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSLineChartView : UIView

/***
 * xTitleArray: X轴数据数组
 * yValueArray: 数据值数组
 * yMax: Y轴最大值
 * yMin: Y轴最小值
 * yTypeName: 代表Y轴是什么类型
 * xTypeName: 代表X轴是什么类型
 * unit: 长按时弹出的数据单位
 * ***/
- (id)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray yMax:(CGFloat)yMax yMin:(CGFloat)yMin yTypeName:(NSString*)yTypeName xTypeName:(NSString*)xTypeName  unit:(NSString*)unit;


@end
