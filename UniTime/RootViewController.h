//
//  RootViewController.h
//  Unitime21
//
//  Created by dmnlk on 11/12/05.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AddView.h"

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
   
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

// 登録画面を呼び出すメソッド
- (void)moveAddView;

@end
