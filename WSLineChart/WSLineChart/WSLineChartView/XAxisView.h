//
//  xAxisView.h
//  3333
//
//  Created by iMac on 16/11/10.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>
#define wsScreenWidth [UIScreen mainScreen].bounds.size.width

@interface XAxisView : UIView


@property (assign, nonatomic) CGFloat pointGap;//点之间的距离
@property (assign,nonatomic)BOOL isShowLabel;//是否显示文字

@property (assign,nonatomic)BOOL isLongPress;//是不是长按状态
@property (assign, nonatomic) CGPoint currentLoc; //长按时当前定位位置
@property (assign, nonatomic) CGPoint screenLoc; //相对于屏幕位置

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
