//
//  xAxisView.m
//  3333
//
//  Created by iMac on 16/11/10.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "XAxisView.h"
#define topMargin 50   // 为顶部留出的空白
#define kChartLineColor         [UIColor grayColor]
#define kChartTextColor         [UIColor blackColor]
#define pointColor              [UIColor colorWithRed:27/255.0 green:168/255.0 blue:248/255.0 alpha:.5]
#define leftMargin 45
#define wsRGBA(r, g, b, a) ([UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a])



@interface XAxisView ()

@property (strong, nonatomic) NSArray *xTitleArray;
@property (strong, nonatomic) NSArray *yValueArray;
@property (assign, nonatomic) CGFloat yMax;
@property (assign, nonatomic) CGFloat yMin;
@property (strong, nonatomic) NSString *xTypeName;
@property (strong, nonatomic) NSString *yTypeName;
@property (strong, nonatomic) NSString *unit;

@property (assign, nonatomic) CGFloat defaultSpace;//X轴点之间的间隔

/**
 *  记录坐标轴的第一个frame
 */
@property (assign, nonatomic) CGRect firstFrame;
@property (assign, nonatomic) CGRect firstStrFrame;//第一个点的文字的frame


@end



@implementation XAxisView

- (id)initWithFrame:(CGRect)frame xTitleArray:(NSArray*)xTitleArray yValueArray:(NSArray*)yValueArray yMax:(CGFloat)yMax yMin:(CGFloat)yMin yTypeName:(NSString*)yTypeName xTypeName:(NSString*)xTypeName  unit:(NSString*)unit {

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.xTitleArray = xTitleArray;
        self.yValueArray = yValueArray;
        self.yMax = yMax;
        self.yMin = yMin;
        self.xTypeName = xTypeName;
        self.yTypeName = yTypeName;
        self.unit = unit;
        
        if (xTitleArray.count > 600) {
            _defaultSpace = 5;
        }
        else if (xTitleArray.count > 400 && xTitleArray.count <= 600){
            _defaultSpace = 10;
        }
        else if (xTitleArray.count > 200 && xTitleArray.count <= 400){
            _defaultSpace = 20;
        }
        else if (xTitleArray.count > 100 && xTitleArray.count <= 200){
            _defaultSpace = 30;
        }
        else if (xTitleArray.count > 10 && xTitleArray.count <= 100){
            _defaultSpace = 40;
        }
        else {
            _defaultSpace = (wsScreenWidth-leftMargin)/xTitleArray.count;
        }


        self.pointGap = (wsScreenWidth-leftMargin)/xTitleArray.count;
        
        
    }
    
    return self;
}

- (void)setPointGap:(CGFloat)pointGap {
    _pointGap = pointGap;
    
    [self setNeedsDisplay];
}

- (void)setIsLongPress:(BOOL)isLongPress {
    _isLongPress = isLongPress;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();

    [self drawShadow];//画渐变色背景

    ////////////////////// X轴文字 //////////////////////////
    // 添加坐标轴Label
    for (int i = 0; i < self.xTitleArray.count; i++) {
        NSString *title = self.xTitleArray[i];
        title = [title stringByReplacingOccurrencesOfString:@" " withString:@"\r\n"];
        
        [[UIColor blackColor] set];
        NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:10]};
        CGSize labelSize = [title sizeWithAttributes:attr];
        
        CGRect titleRect = CGRectMake((i + 1) * self.pointGap - labelSize.width / 2,self.frame.size.height - labelSize.height,labelSize.width,labelSize.height);
        
        if (i == 0) {
            self.firstFrame = titleRect;
            if (titleRect.origin.x < 0) {
                titleRect.origin.x = 0;
            }
            
            [title drawInRect:titleRect withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kChartTextColor}];
            
            //画垂直X轴的竖线
            [self drawLine:context
                startPoint:CGPointMake(titleRect.origin.x+labelSize.width/2, self.frame.size.height - labelSize.height-5)
                  endPoint:CGPointMake(titleRect.origin.x+labelSize.width/2, self.frame.size.height - labelSize.height-10)
                 lineColor:kChartLineColor
                 lineWidth:1];
        }
        // 如果Label的文字有重叠，那么不绘制
        CGFloat maxX = CGRectGetMaxX(self.firstFrame);
        if (i != 0) {
            if ((maxX + 5) > titleRect.origin.x) {
                //不绘制
                
            }else{

                [title drawInRect:titleRect withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kChartTextColor}];
                //画垂直X轴的竖线
                [self drawLine:context
                    startPoint:CGPointMake(titleRect.origin.x+labelSize.width/2, self.frame.size.height - labelSize.height-5)
                      endPoint:CGPointMake(titleRect.origin.x+labelSize.width/2, self.frame.size.height - labelSize.height-10)
                     lineColor:kChartLineColor
                     lineWidth:1];

                self.firstFrame = titleRect;
            }
        }else {
            if (self.firstFrame.origin.x < 0) {
                
                CGRect frame = self.firstFrame;
                frame.origin.x = 0;
                self.firstFrame = frame;
            }
        }
        
    }

    //////////////// 画原点上的x轴 ///////////////////////
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:10]};
    CGSize textSize = [@"22-22\r\n22:22" sizeWithAttributes:attribute];
    
    [self drawLine:context
        startPoint:CGPointMake(0, self.frame.size.height - textSize.height - 5)
          endPoint:CGPointMake(self.frame.size.width, self.frame.size.height - textSize.height - 5)
         lineColor:kChartLineColor
         lineWidth:1];
    

    //////////////// 画横向分割线 ///////////////////////
    CGFloat separateMargin = (self.frame.size.height - topMargin - textSize.height - 5 - 5 * 1) / 5;
    for (int i = 0; i < 5; i++) {
        
        [self drawLine:context
            startPoint:CGPointMake(0, self.frame.size.height - textSize.height - 5  - (i + 1) *(separateMargin + 1))
              endPoint:CGPointMake(self.frame.size.width, self.frame.size.height - textSize.height - 5  - (i + 1) *(separateMargin + 1))
             lineColor:[UIColor lightGrayColor]
             lineWidth:.3];
    }


    /////////////////////// 根据数据源画折线 /////////////////////////
    if (self.yValueArray && self.yValueArray.count > 0) {

        //画折线
        for (NSInteger i = 0; i < self.yValueArray.count; i++) {
            
            //如果是最后一个点
            if (i == self.yValueArray.count-1) {
                
                NSNumber *endValue = self.yValueArray[i];
                CGFloat chartHeight = self.frame.size.height - textSize.height - 5 - topMargin;
                CGPoint endPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);

                //画最后一个点
                UIColor*aColor = pointColor; //点的颜色
                CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
                CGContextAddArc(context, endPoint.x, endPoint.y, 1, 0, 2*M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充

                
                //画点上的文字
                NSString *str = [self removeZeroInFloatString:[NSString stringWithFormat:@"%@",endValue]];
                
                
                NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:10]};
                CGSize strSize = [str sizeWithAttributes:attr];
                
                CGRect strRect = CGRectMake(endPoint.x-strSize.width/2,endPoint.y-strSize.height,strSize.width,strSize.height);
                
                // 如果点的文字有重叠，那么不绘制
                CGFloat maxX = CGRectGetMaxX(self.firstStrFrame);
                if (i != 0) {
                    if ((maxX + 6) > strRect.origin.x) {
                        //不绘制
                        
                    }else{
                        [str drawInRect:strRect withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kChartTextColor}];
                        
                        self.firstStrFrame = strRect;
                    }
                }else {
                    if (self.firstStrFrame.origin.x < 0) {
                        
                        CGRect frame = self.firstStrFrame;
                        frame.origin.x = 0;
                        self.firstStrFrame = frame;
                    }
                }

            }else {
                
                NSNumber *startValue = self.yValueArray[i];
                NSNumber *endValue = self.yValueArray[i+1];
                CGFloat chartHeight = self.frame.size.height - textSize.height - 5 - topMargin;
                
                CGPoint startPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (startValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                CGPoint endPoint = CGPointMake((i+2)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
                
                CGFloat normal[1]={1};
                CGContextSetLineDash(context,0,normal,0); //画实线
                
                [self drawLine:context startPoint:startPoint endPoint:endPoint lineColor:[UIColor colorWithRed:26/255.0 green:135/255.0 blue:254/255.0 alpha:1] lineWidth:1];
                
                
                //画点
                UIColor*aColor = pointColor; //点的颜色
                CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
                CGContextAddArc(context, startPoint.x, startPoint.y, 1, 0, 2*M_PI, 0); //添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充
                
                
                if (!_isShowLabel) {
                    
                    //画点上的文字
                    NSString *str = [self removeZeroInFloatString:[NSString stringWithFormat:@"%@",startValue]];

                    
                    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:10]};
                    CGSize strSize = [str sizeWithAttributes:attr];
                    
                    CGRect strRect = CGRectMake(startPoint.x-strSize.width/2,startPoint.y-strSize.height,strSize.width,strSize.height);
                    if (i == 0) {
                        self.firstStrFrame = strRect;
                        if (strRect.origin.x < 0) {
                            strRect.origin.x = 0;
                        }
                        
                        [str drawInRect:strRect withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kChartTextColor}];
                    }
                    // 如果点的文字有重叠，那么不绘制
                    CGFloat maxX = CGRectGetMaxX(self.firstStrFrame);
                    if (i != 0) {
                        if ((maxX + 6) > strRect.origin.x) {
                            
                        }else{
                            
                            [str drawInRect:strRect withAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:kChartTextColor}];
                            
                            self.firstStrFrame = strRect;
                        }
                    }else {
                        if (self.firstStrFrame.origin.x < 0) {
                            
                            CGRect frame = self.firstStrFrame;
                            frame.origin.x = 0;
                            self.firstStrFrame = frame;
                        }
                    }
                }
            }
            
            
        }
    }
    

    //长按时进入
    if(self.isLongPress)
    {
        int nowPoint = _currentLoc.x/self.pointGap;
        if(nowPoint >= 0 && nowPoint < [self.yValueArray count]) {
            
            NSNumber *num = [self.yValueArray objectAtIndex:nowPoint];
            CGFloat chartHeight = self.frame.size.height - textSize.height - 5 - topMargin;

            CGPoint selectPoint = CGPointMake((nowPoint+1)*self.pointGap, chartHeight -  (num.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);


            CGContextSaveGState(context);

            
            //计算文字最大长度，以便于设置背景宽度
            CGFloat timeWidth = [[NSString stringWithFormat:@"%@:%@",self.xTypeName,self.xTitleArray[nowPoint]] sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor]}].width;
            CGFloat dataWidth = [[NSString stringWithFormat:@"%@:%@%@", self.yTypeName,[NSString stringWithFormat:@"%@",num],self.unit] sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor]}].width;
            CGFloat with = timeWidth > dataWidth ? timeWidth : dataWidth;
            CGFloat shadowWith = with+20;
            
            //画文字所在的位置  动态变化
            CGPoint drawPoint = CGPointZero;
            if(_screenLoc.x-shadowWith/2 > 0 && _screenLoc.x
               +shadowWith/2 < wsScreenWidth-leftMargin) {
                //如果按住的位置在屏幕靠右边边并且在屏幕靠上面的地方   那么字就显示在按住位置的左上角40 60位置
                drawPoint = CGPointMake(selectPoint.x-shadowWith/2, selectPoint.y-45);
            }
            else if(_screenLoc.x >((wsScreenWidth-leftMargin)/2)) {
                //如果按住的位置在屏幕靠右边边并且在屏幕靠上面的地方   那么字就显示在按住位置的左上角40 60位置
                drawPoint = CGPointMake(selectPoint.x-shadowWith-5, selectPoint.y-20);
            }
            else if (_screenLoc.x <= ((wsScreenWidth-leftMargin)/2)) {
                //如果按住的位置在屏幕靠左边边并且在屏幕靠上面的地方   那么字就显示在按住位置的右上角上角40 40位置
                drawPoint = CGPointMake(selectPoint.x+5, selectPoint.y-20);

            }
            
            //画竖线
            [self drawLine:context startPoint:CGPointMake(selectPoint.x, 0) endPoint:CGPointMake(selectPoint.x, self.frame.size.height- textSize.height - 5) lineColor:[UIColor lightGrayColor] lineWidth:1];
            
            // 交界点
            CGRect myOval = {selectPoint.x-2, selectPoint.y-2, 4, 4};
            CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
            CGContextAddEllipseInRect(context, myOval);
            CGContextFillPath(context);
            
            
            //设置数据背景，放在竖线之后加载，不会被竖线遮住
            CGContextSetFillColorWithColor(context, wsRGBA(1, 0, 0, 0.5).CGColor);
            CGPathRef clippath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(drawPoint.x, drawPoint.y, with+20, 40) cornerRadius:10].CGPath;
            CGContextAddPath(context, clippath);
            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathFill);

            [[NSString stringWithFormat:@"%@:%@",self.xTypeName,self.xTitleArray[nowPoint]] drawInRect:CGRectMake(drawPoint.x+10, drawPoint.y+5, with, 15) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor]}];
            [[NSString stringWithFormat:@"%@:%@%@", self.yTypeName,[NSString stringWithFormat:@"%@",num],self.unit] drawInRect:CGRectMake(drawPoint.x+10, drawPoint.y+20, with, 15) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor]}];

            

        }
    }
    
    

}

- (void)drawShadow {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont systemFontOfSize:10]};
    CGSize textSize = [@"22-22\r\n22:22" sizeWithAttributes:attribute];
    
    CGPathMoveToPoint(path, NULL, self.pointGap, self.frame.size.height - textSize.height-5);
    NSNumber *startValue = self.yValueArray[0];
    CGFloat chartHeight = self.frame.size.height - textSize.height - 5 - topMargin;
    CGPoint firstStartPoint = CGPointMake(self.pointGap, chartHeight -  (startValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
    CGPathAddCurveToPoint(path,  NULL,(self.pointGap+firstStartPoint.x)/2, self.pointGap, (self.pointGap+firstStartPoint.x)/2, firstStartPoint.y, firstStartPoint.x, firstStartPoint.y);

    
    //画折线
    for (NSInteger i = 0; i < self.yValueArray.count; i++) {
        CGFloat chartHeight = self.frame.size.height - textSize.height - 5 - topMargin;
        NSNumber *startValue = self.yValueArray[i];
        CGPoint startPoint = CGPointMake((i+1)*self.pointGap, chartHeight -  (startValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);

        if (i == self.yValueArray.count-1) {
            CGPathAddLineToPoint(path, NULL, startPoint.x,startPoint.y);
        }
        else {
            NSNumber *endValue = self.yValueArray[i+1];
            CGPoint endPoint = CGPointMake((i+2)*self.pointGap, chartHeight -  (endValue.floatValue-self.yMin)/(self.yMax-self.yMin) * chartHeight+topMargin);
            
            CGPathAddCurveToPoint(path,  NULL,(startPoint.x+endPoint.x)/2, startPoint.y, (startPoint.x+endPoint.x)/2, endPoint.y, endPoint.x, endPoint.y);
        }
        
    }
    
    CGPathAddLineToPoint(path, NULL, self.pointGap*self.yValueArray.count, self.frame.size.height - textSize.height-5);
    CGPathCloseSubpath(path);
    //绘制渐变
    [self drawLinearGradient:context path:path startColor:[UIColor colorWithRed:26/255.0 green:135/255.0 blue:254/255.0 alpha:1].CGColor endColor:[UIColor whiteColor].CGColor];
    //注意释放CGMutablePathRef
    CGPathRelease(path);
}


- (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor lineWidth:(CGFloat)width {
    
    CGContextSetShouldAntialias(context, YES ); //抗锯齿
    CGColorSpaceRef Linecolorspace1 = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorSpace(context, Linecolorspace1);
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
//    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextAddCurveToPoint(context, (startPoint.x+endPoint.x)/2, startPoint.y, (startPoint.x+endPoint.x)/2, endPoint.y, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGColorSpaceRelease(Linecolorspace1);

}


- (void)drawLinearGradient:(CGContextRef)context path:(CGPathRef)path startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor{

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

//去掉小数点之后的无效0；
-(NSString*)removeZeroInFloatString:(NSString*)floatString {
    NSString *outNumber = [NSString stringWithFormat:@"%@",@(floatString.longLongValue)];
    return outNumber;
}

@end
