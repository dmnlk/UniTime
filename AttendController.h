//
//  AttendController.h
//  Attend
//
//  Created by owner_mac on 11/11/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class VerticallyAlignedLabel;


@interface AttendController : UITableViewController{
    
    UISegmentedControl *WeekSeg; 
}

-(void)TateSen;
-(void)YokoSen;
-(void)YoubiSelect;
-(void)tableSettei;
-(void)naviSettei;


- (void)WeeklySegChanged:(id)sender;
@end
