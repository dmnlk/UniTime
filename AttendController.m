//
//  AttendViewController.m
//  Uninavi_attend
//
//  Created by owner_mac on 11/11/16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AttendController.h"
#import "AttendCell.h"
#import "AttendUpdate.h"
#define CUSTOM_CELL_NIB @"AttendCell"


@implementation AttendController


- (void)viewDidLoad
{
    [super viewDidLoad];  
    [self naviSettei];
    [self tableSettei];
    [self YoubiSelect];
    [self TateSen];
    [self YokoSen];
    
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
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttendCell *cell = (AttendCell *)[tableView dequeueReusableCellWithIdentifier:CUSTOM_CELL_NIB];
    if (cell == nil) {
        UINib* nib =[UINib nibWithNibName:CUSTOM_CELL_NIB bundle:nil];
        NSArray* array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
    int r = rand();     //reloadDataの動作確認のための乱数
    
    cell.SubjectLabel.text = [NSString stringWithFormat:@"文学-%d",r];
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
    return headerView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return WeekSeg.selectedSegmentIndex+1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
