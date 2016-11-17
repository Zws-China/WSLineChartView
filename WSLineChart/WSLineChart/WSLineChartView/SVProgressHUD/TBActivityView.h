//
//  TBActivityView.h
//  TBActivityView
//
//  Created by MacBook Pro on 14-6-19.
//  Copyright (c) 2014年 zhaoonline. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBActivityView : UIView
/**
 *  小方块个数
 */
@property(readwrite , nonatomic) NSUInteger numberOfRect;

/**
 *  小方块背景色
 */
@property(strong , nonatomic) UIColor* rectBackgroundColor;

/**
 *  self.frame.size
 */
@property(readwrite , nonatomic) CGSize defaultSize;

/**
 *  小方块之间的间距
 */
@property(readwrite , nonatomic) CGFloat spacing;

/**
 *  开始动画
 */
-(void)startAnimate;


/**
 *  结束动画
 */
-(void)stopAnimate;
@end
