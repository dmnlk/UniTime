//
//  UniTimeAppDelegate.h
//  UniTime
//
//  Created by dmnlk on 11/12/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface UniTimeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    NSString *todayy;
    NSUInteger weekdayint;
    NSArray *weekarray;
    NSMutableArray *Subj;
    NSString *attyoubi;
    int hoge;

    NSManagedObjectContext *managedObject_;
    NSManagedObjectModel *managedModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (retain,nonatomic)NSString *todayy;
@property (assign,nonatomic)NSUInteger weekdayint;
@property (retain,nonatomic)NSArray *weekarray;
@property (nonatomic,retain)NSMutableArray *Subj;
@property (assign,nonatomic)int hoge;
@property (assign,nonatomic)NSString *attyoubi;

@end
