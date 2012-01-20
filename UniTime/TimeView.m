//
//  TimeView.m
//  TabNavTableTest
//
//  Created by dmnlk on 11/11/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeView.h"


@implementation TimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor grayColor] setStroke];
    UIBezierPath *path =[UIBezierPath bezierPath];
    [path setLineWidth:0.5];
    //基本の1本
    /*
    [path moveToPoint:CGPointMake(0,20)];
    [path addLineToPoint: CGPointMake(320, 20)];
    [path stroke];
    
    //曜日を分ける線
    float y_path=20;
    float view_y_size = self.bounds.size.height;
    float day_section_size =6;
    view_y_size -= 20;
    for (int i=0; i<day_section_size; i++) {
        
        y_path += view_y_size/day_section_size;
        [path moveToPoint:CGPointMake(0,y_path)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, y_path)];
        [path stroke];
    }
    
    //時限を分ける線
    float x_path =0;
    float view_x_size = self.bounds.size.width;
    float time_section_size =6;
    view_x_size -=0;
    
    for (int i =0; i<time_section_size; i++) {
        x_path += view_x_size/time_section_size;
        [path moveToPoint:CGPointMake(x_path, 0)];
        [path addLineToPoint:CGPointMake(x_path, self.bounds.size.height)];
        [path stroke];
    }
    */
    //基本の1本
    [path moveToPoint:CGPointMake(20,0)];
    [path addLineToPoint: CGPointMake(20, 320)];
    [path stroke];
    
    //曜日を分ける線
    float y_path=20;
    float view_y_size = self.bounds.size.width;
    float day_section_size =6;
    view_y_size -= 20;
    for (int i=0; i<day_section_size; i++) {
        
        y_path += view_y_size/day_section_size;
        [path moveToPoint:CGPointMake(y_path,0)];
        [path addLineToPoint:CGPointMake(y_path, self.bounds.size.width)];
        [path stroke];
    }
    
    //時限を分ける線
    float x_path =0;
    float view_x_size = self.bounds.size.height;
    float time_section_size =6;
    for (int i =0; i<time_section_size; i++) {
        x_path += view_x_size/time_section_size;
        [path moveToPoint:CGPointMake(0, x_path)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, x_path)];
        [path stroke];
    }

}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
