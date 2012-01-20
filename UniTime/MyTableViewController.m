//
//  MyTableViewController.m
//  UniTime
//
//  Created by dmnlk on 11/10/05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyTableViewController.h"
#import "CusCell.h"
#import "InputView.h"
#import "MyView.h"
#import "UniTimeAppDelegate.h"

@implementation MyTableViewController
@synthesize appDelegate;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{   [appDelegate release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //左側のItem
    
    UIBarButtonItem *showappButton =[[UIBarButtonItem alloc]initWithTitle:@"一覧" style:UIBarButtonItemStylePlain target:self action:@selector(showView)];
    
    self.navigationItem.leftBarButtonItem =showappButton;
    
    //右側のItem
    
    NSArray *array = [NSArray arrayWithObjects:[UIImage imageNamed:@"prev.png"],[UIImage imageNamed:@"next.png"], nil];
    UISegmentedControl *segmentControl =[[[UISegmentedControl alloc]initWithItems:array]autorelease];
    [segmentControl addTarget:self action:@selector(respondToPageControlClick:) forControlEvents:UIControlEventValueChanged];
    segmentControl.segmentedControlStyle =UISegmentedControlStyleBar;
    segmentControl.momentary = YES;
    UIBarButtonItem *rightItem =[[[UIBarButtonItem alloc]initWithCustomView:segmentControl] autorelease];
    [[self navigationItem]setRightBarButtonItem:rightItem];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
    self.navigationItem.title = appDelegate.todayy;
    NSLog(@"Testcode");
    [self showView];
    [showappButton release];
    self.tableView.separatorColor=[UIColor blackColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CusCell *cell = (CusCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController* controller;
        controller = [[UIViewController alloc]initWithNibName:@"CusCell" bundle:nil];
        cell = (CusCell*)controller.view;
        [controller release];
    }
    
    // Configure the cell...
    cell.tag= indexPath.row+1;
    cell.kamoku.text =[NSString stringWithFormat:@"%d",cell.tag];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //cellの時間割
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    cell.lessson.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:indexPath.row+1] stringValue]] objectForKey:@"lesson"];
    
    cell.room.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:indexPath.row+1] stringValue]] objectForKey:@"room"];
    
    cell.teacher.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:indexPath.row+1] stringValue]] objectForKey:@"teacher"];
    [defaults synchronize];
    NSArray *startArrry = [NSArray arrayWithObjects:@"09:00",@"10:45",@"13:05",@"14:50",@"16:35",@"18:20", nil];
    NSArray *endArrry = [NSArray arrayWithObjects:@"10:30",@"12:15",@"14:35",@"16:20",@"18:05",@"19:50", nil];
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
    cell.haihun.transform = transform;
    cell.startTime.text = [startArrry objectAtIndex:indexPath.row];
    cell.endTime.text = [endArrry objectAtIndex:indexPath.row];
//    cell.imageView.image =[UIImage imageNamed:@"bicon.png"];
    return cell;
    
    
}
    /*
     // Override to support conditional editing of the table view.
     - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
     {
     // Return NO if you do not want the specified item to be editable.
     return YES;
     }
     */
    
    /*
     // Override to support editing the table view.
     - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
     {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
     // Delete the row from the data source
     [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
     }   
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }   
     }
     */

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    
    // Navigation logic may go here. Create and push another view controller.
    
     InputView *pushViewController = [[InputView alloc] initWithNibName:@"InputView" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     
    pushViewController.time = indexPath.row+1;
     [self.navigationController pushViewController:pushViewController animated:YES];
     [pushViewController release];
     
    
}
-(IBAction)respondToPageControlClick:(id)sender{
    
    UniTimeAppDelegate *appDelegater =[(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
        
    if ([sender selectedSegmentIndex] == 0) {
        if (appDelegater.weekdayint==1) {
            appDelegater.weekdayint=6;
            appDelegater.todayy = [appDelegater.weekarray objectAtIndex:(int)appDelegater.weekdayint];
            self.navigationItem.title=appDelegater.todayy;
            
        }else{
            appDelegater.weekdayint--;
            appDelegater.todayy = [appDelegater.weekarray objectAtIndex:(int)appDelegater.weekdayint];
            self.navigationItem.title =appDelegater.todayy;
            
            
        }
        [self.tableView reloadData];
    }else{
        
        if (appDelegater.weekdayint<=6) {
            if (appDelegater.weekdayint==6) {
                appDelegater.weekdayint=0;
                appDelegater.todayy = [appDelegater.weekarray objectAtIndex:(int)appDelegater.weekdayint];
                self.navigationItem.title =appDelegater.todayy;
                
            }
            appDelegater.weekdayint++;
            appDelegater.todayy = [appDelegater.weekarray objectAtIndex:(int)appDelegater.weekdayint];
            self.navigationItem.title =appDelegater.todayy;
        }
        [self.tableView reloadData]; 
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat barHeight = self.navigationController.navigationBar.bounds.size.height;
    CGFloat viewHeight = self.view.window.bounds.size.height;
    CGFloat tabbarHeight = self.tabBarController.tabBar.bounds.size.height;
    
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarheight =statusBarFrame.size.height;
    CGFloat cellHeight =(viewHeight-barHeight-tabbarHeight-statusBarheight)/3;
    return cellHeight;
   
}
-(void)showView{
    
    MyView *modalView = [[MyView alloc]initWithNibName:@"MyView" bundle:nil];
    modalView.delegate =self;
    [self presentModalViewController:modalView animated:NO];
    [modalView release];
}

-(void)modalViewWillClose{
    [self dismissModalViewControllerAnimated:YES];
}

/*TODO.フリックで削除する
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
    static NSString *CellIdentifier = @"Cell";
    CusCell *cell = (CusCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController* controller;
        controller = [[UIViewController alloc]initWithNibName:@"CusCell" bundle:nil];
        cell = (CusCell*)controller.view;
        
    }
    

    appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    for (NSString *day in [defaults objectForKey:@"Data"]) {
        if([day isEqualToString:appDelegate.todayy]){
            for (NSString *timed in [[defaults objectForKey:@"Data"] objectForKey:day]) {
                if ([timed isEqualToString:[[NSNumber numberWithUnsignedInt:time] stringValue]]) {
                    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:[defaults objectForKey:@"Data"]];
                    NSMutableDictionary *c =[NSMutableDictionary dictionaryWithDictionary:[d objectForKey:day]];
                    NSMutableDictionary *b =[NSMutableDictionary dictionaryWithDictionary:[c objectForKey:timed]];
                    [b setObject:@"" forKey:@"lesson"];
                    [b setObject:@"" forKey:@"room"];
                    [b setObject:@"" forKey:@"teacher"];
                    
                    [c setObject:b forKey:timed];
                    [d setObject:c forKey:day];
                    
                    [defaults setObject:d forKey:@"Data"];
                    [defaults synchronize];
                }
            }
        }
    }
    cell.lessson.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:indexPath.row+1] stringValue]] objectForKey:@"lesson"];
    
    
    cell.room.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:indexPath.row+1] stringValue]] objectForKey:@"room"];
    
    cell.teacher.text= [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.todayy] objectForKey:[[NSNumber numberWithUnsignedInteger:indexPath.row+1] stringValue]] objectForKey:@"teacher"];
    
    [defaults synchronize];
}
*/
@end
