//
//  RootViewController.m
//  Unitime21
//
//  Created by dmnlk on 11/12/05.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import "RootViewController.h"
#import "UniTimeAppDelegate.h"
enum
{
    EntityKind = 1,    
};

@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation RootViewController
@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;



#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"Cancel";
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    

    // Set up the edit and add buttons.
   /* UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
																			   target:self 
																			   action:@selector(moveAddView)];
    

    
    self.navigationItem.leftBarButtonItem = editButton;
    
*/
    /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.title = @"Delete";
     */
    
    self.navigationItem.leftBarButtonItem
    = [[[UIBarButtonItem alloc]
        initWithTitle:@"delete"
        style:UIBarButtonItemStylePlain
        target:self
        action:@selector(startEditing)] autorelease];
    
	// 登録画面を開くボタンに変更
   /*
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
																			   target:self 
																			   action:@selector(moveAddView)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    */
    
    self.navigationItem.rightBarButtonItem
    = [[[UIBarButtonItem alloc]
        initWithTitle:@"登録"
        style:UIBarButtonItemStylePlain
        target:self
        action:@selector(moveAddView)] autorelease];
    
    
    
    [self setTitle:NSLocalizedString(@"課題管理", @"")];
    
}
-(void)startEditing{
    // 編集モードにする
	[self.tableView setEditing:YES animated:YES];
	
    // navigation Barの右側に[Done]ボタンを表示する。
	self.navigationItem.leftBarButtonItem
	= [[[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemDone
        target:self
		action:@selector(stopEditing)] autorelease];
}

-(void)stopEditing{
    // 編集モードをやめる
	[self.tableView setEditing:NO animated:YES];
    
	// navigation Barの右側に[Edit]ボタンを表示する。
	self.navigationItem.leftBarButtonItem
	= [[[UIBarButtonItem alloc]
		initWithTitle:@"delete"
        style:UIBarButtonItemStylePlain
        target:self
		action:@selector(startEditing)] autorelease];
}


// Implement viewWillAppear: to do additional setup before the view is presented.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
    NSManagedObject *managedObject = 
    [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // 文字列を取得して、セルに設定する
    cell.textLabel.text =
    [[managedObject valueForKey:@"jugyo2"] description];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"HH時mm分"];
	// 日付の書式を変更
	NSString *dateString = [formatter stringFromDate:
							[managedObject valueForKey:@"timeStamp"]];
	// 書式を解放
	[formatter release];
	// textLabelに日付を表示
	cell.detailTextLabel.text = dateString;
	//cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];
	
    
    /*
     cell.detailTextLabel.text = [managedObject valueForKey:@"memo"];*/
    
}


#pragma mark -
#pragma mark Add a new object


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchedResultsController sections] count];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo name];
    
}

NSInteger BadgeNumber =  0;
int fl = 0;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    NSLog(@"11111");
    NSLog(@"%d",BadgeNumber);
    if(fl == 0){
        BadgeNumber =  
        [sectionInfo numberOfObjects] + BadgeNumber;
    }
    else if(fl == 1){
        BadgeNumber = 0;
        BadgeNumber =  
        [sectionInfo numberOfObjects] + BadgeNumber;
        fl = 0;
    }
    
    NSLog(@"%d",BadgeNumber);
    NSLog(@"%d",[sectionInfo numberOfObjects]);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:BadgeNumber];
     
    return [sectionInfo numberOfObjects];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		// テーブルビューのスタイルを変更
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    if (editing) { // 現在編集モードです。
        UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                    target:self action:@selector(addRow:)] autorelease];
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES]; // 追加ボタンを表示します。
         
         self.navigationItem.leftBarButtonItem.title = @"elete"; 
    } else { // 現在通常モードです。  
        self.navigationItem.leftBarButtonItem.title = @"Delete"; // 追加ボタンを非表示にします。
    }
}
*/
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    {
        
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
       // self.navigationItem.leftBarButtonItem.title = @"Delete";
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
            
        }
    }   
}
    
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate
- (void)showDetailViewController:(id)controller
{
    UINavigationController *navController;
    navController = self.navigationController;
    [navController pushViewController:controller
                             animated:YES];
    
}   



- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSManagedObject *obj;
    obj = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    id controller = nil;
    NSInteger kind;
    kind = [[obj valueForKey:@"kind"] intValue];
    
    switch (kind)
    {
        case EntityKind:
            controller = [[AddView alloc] init];
            [controller setManagedObject:obj];
            /*[self moveAddView:controller];*/
            fl = 1;
            [self showDetailViewController:controller];
            [controller release];
            break;
    }
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController_ != nil) {
        return fetchedResultsController_;
    }
	
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
	// ソートを昇順に変更
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"timeStamp2" cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    return fetchedResultsController_;
    
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            fl = 1;
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView endUpdates];
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
  //  NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    
    
    NSError *error = nil;
    //[entity release];
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
}


/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView ];
 }
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

// 登録画面を呼び出す
- (void)moveAddView {
	// 登録画面を作成
    fl = 1;
  //  NSManagedObjectContext *context = 
    [self.fetchedResultsController managedObjectContext];
    
    // 新しいオブジェクトを作成して、オブジェクトコンテキストに追加する
    // 作成したオブジェクトに初期値を設定する
    /*[newManagedObject setValue:[NSDate date] forKey:@"date"];*/
    
	AddView *detailViewController
	= [[AddView alloc] initWithNibName:@"AddView" bundle:nil];
	
	// 「self.fetchedResultsController」を登録画面に渡す
	detailViewController.fetchedResultsController = self.fetchedResultsController;
	
	// 登録画面へ移動
	[self.navigationController pushViewController:detailViewController
										 animated:YES];
	[detailViewController release];
    
    AddView *viewController;
    viewController = [[AddView alloc] init];
    // 編集画面を表示する
    [viewController release];
  //  [NSManagedObjectContext release];
    
}


- (void)dealloc {
    [fetchedResultsController_ release];
    [managedObjectContext_ release];
    [super dealloc];
}


@end
