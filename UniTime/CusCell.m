//
//  CusCell.m
//  TabNavTableTest
//
//  Created by dmnlk on 11/10/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CusCell.h"


@implementation CusCell
@synthesize kamoku;
@synthesize lessson;
@synthesize room;
@synthesize teacher;
@synthesize startTime;
@synthesize haihun;
@synthesize endTime;

- (void)dealloc
{
    [kamoku release];
    [lessson release];
    [room release];
    [teacher release];
    [startTime release];
    [haihun release];
    [endTime release];
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)drawRect:(CGRect)rect{
    // グラフィックコンテキスト取得
    CGContextRef context = UIGraphicsGetCurrentContext();
      
        // CGContextを用意する
      /*  
        // CGGradientを生成する
        // 生成するためにCGColorSpaceと色データの配列が必要になるので
        // 適当に用意する
        CGGradientRef gradient;
        CGColorSpaceRef colorSpace;
        size_t num_locations = 2;
        CGFloat locations[2] = { 0.0, 1.0 };
        CGFloat components[8] = { 1.0, 1.0, 1.0, 1.0,  // Start color
            0.79, 0.79, 0.79, 1.0 }; // End color
        colorSpace = CGColorSpaceCreateDeviceRGB();
        gradient = CGGradientCreateWithColorComponents(colorSpace, components,
                                                       locations, num_locations);
        
        // 生成したCGGradientを描画する
        // 始点と終点を指定してやると、その間に直線的なグラデーションが描画される。
        // （横幅は無限大）
        CGPoint startPoint = CGPointMake(self.frame.size.width/2, 0.0);
        CGPoint endPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        
        // GradientとColorSpaceを開放する
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
    
    */
    //////こっから直線描画
    
    // CoreGraphicsの原点が左下なので原点を合わせる
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0); 
    
    // 線の色を黒
    UIColor *color = [UIColor blackColor];
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
    // 線の太さ
    CGContextSetLineWidth(context,1);
    
    // Pathを作成
    CGContextBeginPath(context);
    // Pathの位置設定
    /*
     CGContextMoveToPoint(context, 100.0, 100.0);
     CGContextAddLineToPoint(context, 50.0, 150.0);
     CGContextAddLineToPoint(context, 100.0, 150.0);
     */
    CGContextMoveToPoint(context, 50.0, 0.0);
    CGContextAddLineToPoint(context, 50.0, 129.0);
    
    // Pathの描画
    //CGContextDrawPath(context, kCGPathStroke);
    
    // 描画
    CGContextFlush(context);
    [self.kamoku.textColor setFill];
	//ビューの横に10ピクセル、縦に50ピクセル内側に入った矩形で塗りつぶす。
	UIRectFill(CGRectInset(CGRectMake(0, 0,50, self.frame.size.height), 0, 0));	
}


@end
