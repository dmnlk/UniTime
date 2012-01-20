//
//  AttendController.h
//  Attend
//
//  Created by dmnlk on 11/11/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniTimeAppDelegate.h"


@interface AttendController : UITableViewController <UIApplicationDelegate>{
    UISegmentedControl *WeekSeg;     
    UniTimeAppDelegate *appDelegate;
    int SubSum;
}


@property (nonatomic,retain)UniTimeAppDelegate *appDelegate;

-(void)TateSen;
-(void)YokoSen;
-(void)YoubiSelect;
-(void)tableSettei;
-(void)naviSettei;
-(void)Sousa;

- (void)WeeklySegChanged:(id)sender;
@end
