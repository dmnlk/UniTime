//
//  MyTableViewController.h
//  UniTime
//
//  Created by dmnlk on 11/10/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UniTimeAppDelegate.h"

@interface MyTableViewController : UITableViewController {
    UniTimeAppDelegate *appDelegate;
}
@property (nonatomic,retain)UniTimeAppDelegate *appDelegate;
-(void)showView;
@end
