//
//  AttendViewController.m
//  Uninavi_attend
//
//  Created by dmnlk on 11/11/16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AttendController.h"
#import "AttendCell.h"
#import "AttendUpdate.h"
#import "UniTimeAppDelegate.h"
#define CUSTOM_CELL_NIB @"AttendCell"



@implementation AttendController
@synthesize appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];  
    appDelegate = [(UniTimeAppDelegate *)[UIApplication sharedApplication] delegate];
    appDelegate.Subj = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0],[NSNumber numberWithInt:0], nil];
    [self naviSettei];
    [self tableSettei];
    [self YoubiSelect];
    [self TateSen];
    [self YokoSen];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self Sousa];
    [self.tableView reloadData];    
}

- (void)naviSettei      //ナビゲーションバーの設定
{
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]init];
    backButton.title = @"戻る";
    self.navigationItem.backBarButtonItem = backButton;
    self.navigationItem.prompt = @"出欠管理";
    
    //以下SegmentedControllの生成及び設定
    WeekSeg = [[UISegmentedControl alloc] initWithItems:nil];
    WeekSeg.segmentedControlStyle = UISegmentedControlStyleBar;
    WeekSeg.frame = CGRectMake(0,0,300,30);
    [WeekSeg insertSegmentWithTitle:@"月" atIndex:0 animated:YES];
    [WeekSeg insertSegmentWithTitle:@"火" atIndex:1 animated:YES];
    [WeekSeg insertSegmentWithTitle:@"水" atIndex:2 animated:YES];
    [WeekSeg insertSegmentWithTitle:@"木" atIndex:3 animated:YES];
    [WeekSeg insertSegmentWithTitle:@"金" atIndex:4 animated:YES];    
    [WeekSeg insertSegmentWithTitle:@"土" atIndex:5 animated:YES];     
    [WeekSeg addTarget:self action:@selector(WeeklySegChanged:) forControlEvents:UIControlEventValueChanged];    
    self.navigationItem.titleView = WeekSeg;
}


- (void)YoubiSelect     //曜日切り替えボタンを当日の曜日に合わせる
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)fromDate:date];
    NSInteger weekday = [comps weekday];
    if(weekday == 1) weekday++;
    WeekSeg.selectedSegmentIndex = weekday-2;
    
}


- (void)WeeklySegChanged:(id)sender{       //曜日切り替えボタンを押した際の動作
    [self.tableView reloadData];
}

- (void)Sousa{      //dictionaryのどこに授業が格納されているか捜査
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *SubCount;
    SubSum = 0;
    int weeksele = WeekSeg.selectedSegmentIndex+1;
    appDelegate.attyoubi = [appDelegate.weekarray objectAtIndex:weeksele];
    
    for(int i=0;i<6;i++){
        [appDelegate.Subj replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
        //NSLog(@"%@ : %d", appDelegate.attyoubi,[[appDelegate.Subj objectAtIndex:i] intValue]);
    }
    
    for(int i=1;i<7;i++){
        SubCount = [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.attyoubi] objectForKey:[[NSNumber numberWithUnsignedInteger:i] stringValue]] objectForKey:@"lesson"];
        if(SubCount.length > 0){
            [appDelegate.Subj replaceObjectAtIndex:i-1 withObject:[NSNumber numberWithInt:1]];
            SubSum++;
        }
        //NSLog(@"%@ : %d", appDelegate.attyoubi,[[appDelegate.Subj objectAtIndex:i-1] intValue]);
    }
}



- (void)tableSettei{        //テーブルビューの設定
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.rowHeight = 52;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
}


- (void)TateSen     //テーブルビューに縦線を引く
{
    CGRect rect;
    UILabel *tatelabel;
    for(int i=0;i<4;i++){
        rect = CGRectMake(160+40*i, 0, 1, 361);
        tatelabel = [[UILabel alloc]initWithFrame:rect];
        tatelabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
        [self.view addSubview:tatelabel];
        [tatelabel release];
    }    
}

- (void)YokoSen     //ヘッダの1px下に横線を引く。無くても殆ど変わらんかも
{
    CGRect rect = CGRectMake(0,25,320,1);
    UILabel *yokolabel = [[UILabel alloc]initWithFrame:rect];
    yokolabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    [self.view addSubview:yokolabel];
    [yokolabel release];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttendCell *cell = (AttendCell *)[tableView dequeueReusableCellWithIdentifier:CUSTOM_CELL_NIB];
    if (cell == nil) {
        UINib* nib =[UINib nibWithNibName:CUSTOM_CELL_NIB bundle:nil];
        NSArray* array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for(int i=1;i<7;i++){
        //NSLog(@"%d",i);
        if([[appDelegate.Subj objectAtIndex:i-1] intValue] == 1){
            cell.SubjectLabel.text = [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.attyoubi] objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"lesson"];
            cell.AttendLabel.text = [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.attyoubi] objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"att"];
            cell.KessekiLabel.text = [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.attyoubi] objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"abs"];
            cell.ChikokuLabel.text = [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.attyoubi] objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"late"];
            cell.KyukoLabel.text = [[[[defaults objectForKey:@"Data"] objectForKey:appDelegate.attyoubi] objectForKey:[[NSNumber numberWithInt:i] stringValue]] objectForKey:@"kyuko"];
            [appDelegate.Subj replaceObjectAtIndex:i-1 withObject:[NSNumber numberWithInt:10]];
            break;
        } 
    }
    
    [defaults synchronize];
    // Configure the cell.
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //以下ヘッダの生成
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    headerView.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.7 alpha:1.0];
    [self.tableView addSubview:headerView];
    
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 6, 70, 25)];
    headerLabel.text = @"授業名";
    headerLabel.backgroundColor = [UIColor clearColor];    
    headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor whiteColor];
    headerLabel.shadowColor = [UIColor darkGrayColor];
	headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.shadowOffset = CGSizeMake(0, 1);
	headerLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3"size:17];
    [headerView addSubview:headerLabel];
    [headerLabel release];
    
    
    for(int i=0;i<4;i++){
        headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(163+40*i, 6, 40, 25)];
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.opaque = NO;
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.shadowColor = [UIColor darkGrayColor];
        headerLabel.highlightedTextColor = [UIColor whiteColor];
        headerLabel.shadowOffset = CGSizeMake(0, 1);
        headerLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3"size:17];        
        switch(i){
            case 0:
                headerLabel.text = @"出席";
                break;
            case 1:
                headerLabel.text = @"欠席";
                break;
            case 2:
                headerLabel.text = @"遅刻";
                break;
            case 3:
                headerLabel.text = @"休講";
                break;
        }        
        [headerView addSubview:headerLabel];
        [headerLabel release];
    }
    
    CGRect rect;
    UILabel *tatelabel;
    for(int i=0;i<4;i++){
        rect = CGRectMake(160+40*i, 0, 1, 25);
        tatelabel = [[UILabel alloc]initWithFrame:rect];
        tatelabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
        [headerView addSubview:tatelabel];
        [tatelabel release];
    } 
    
    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self Sousa];
    return SubSum;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int j = 0;
    for(int i=0;i<6;i++){
        if([[appDelegate.Subj objectAtIndex:i] intValue] == 10){
            if(indexPath.row == j){
                [appDelegate.Subj replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:20]];
                break;
            }
            j++;
        }
    }
    AttendUpdate *controller = [[AttendUpdate alloc] initWithNibName:@"AttendUpdate" bundle:nil];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
