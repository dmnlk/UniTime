//
//  UniTimeAppDelegate.m
//  UniTime
//
//  Created by dmnlk on 11/12/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UniTimeAppDelegate.h"
#import "RootViewController.h"
@implementation UniTimeAppDelegate


@synthesize window=_window;

@synthesize managedObjectContext=__managedObjectContext;

@synthesize managedObjectModel=__managedObjectModel;

@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;

@synthesize tabBarController=_tabBarController;

@synthesize navigationController = _navigationController;
@synthesize todayy;
@synthesize weekdayint;
@synthesize weekarray;
@synthesize hoge;
@synthesize Subj;
@synthesize attyoubi;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{ 
    weekarray = [[NSArray alloc]initWithObjects:@"日曜日",@"月曜日",@"火曜日",@"水曜日",@"木曜日",@"金曜日",@"土曜日",nil];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date =[[NSDate alloc]init];
    NSDateComponents *c = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    hoge =[c weekday];
    hoge--;
  
    if (hoge ==0) {
        hoge =1;
    }
 
    todayy =[weekarray objectAtIndex:hoge];
    weekdayint = hoge;
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    
    
    //NSUserDefaultの確認
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [date release];
    if([defaults boolForKey:@"exist"] ==TRUE){
        NSLog(@"Dictionary exist");
        
    }else{
         [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        NSLog(@"Dictionary none");
        //空の辞書生成
        NSMutableDictionary *Dic =[NSMutableDictionary dictionary];
        NSMutableDictionary *dayDic =[NSMutableDictionary dictionary];
        NSMutableDictionary *timeDic =[NSMutableDictionary dictionary];
        for (NSString *day in weekarray) {
            for (int i = 1; i<7; i++) {
                [timeDic setObject:@"" forKey:@"lesson"];
                [timeDic setObject:@"" forKey:@"room"];
                [timeDic setObject:@"" forKey:@"teacher"];
                [timeDic setObject:@"0" forKey:@"att"];
                [timeDic setObject:@"0" forKey:@"abs"];
                [timeDic setObject:@"0" forKey:@"late"];
                [timeDic setObject:@"0" forKey:@"kyuko"];
                [dayDic setObject:timeDic forKey:[[NSNumber numberWithInt:i] stringValue]];
                [Dic setObject:dayDic forKey:day];
            }
        }
        [defaults setObject:Dic forKey:@"Data"];
        NSLog(@"launch Dic = %@",[defaults objectForKey:@"Data"]);
        [defaults setBool:TRUE forKey:@"exist"];
        [defaults synchronize];
    }
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [_tabBarController release];
    [_navigationController release];
    [super dealloc];
}

- (void)awakeFromNib
{
    RootViewController *rootViewController = (RootViewController *)[self.navigationController topViewController];
    rootViewController.managedObjectContext = self.managedObjectContext;
    /*
     Typically you should set up the Core Data stack here, usually by passing the managed object context to the first view controller.
     self.<#View controller#>.managedObjectContext = self.managedObjectContext;
     */
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UniTime" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UniTime.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

@end
